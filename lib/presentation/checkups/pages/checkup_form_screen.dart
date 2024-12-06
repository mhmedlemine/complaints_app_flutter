import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/save_checkup_dto.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:complaintsapp/core/domain/enums.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/presentation/checkups/pages/summon_details.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/dialogs/dialog_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CheckupFormScreen extends StatefulWidget {
  final Checkup checkup;

  const CheckupFormScreen({Key? key, required this.checkup}) : super(key: key);

  @override
  _CheckupFormScreenState createState() => _CheckupFormScreenState();
}

class _CheckupFormScreenState extends State<CheckupFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _statusController =
      TextEditingController(text: AppLocalizations.instance.translate('clean'));
  final _actionController =
      TextEditingController(text: AppLocalizations.instance.translate('none'));
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();

  // Focus nodes
  late FocusNode _notesFocusNode;

  // Stores
  final CheckupStore _checkupStore = getIt<CheckupStore>();
  final FormStore _formStore = getIt<FormStore>();

  DateTime _pickedDate = DateTime.now().add(Duration(days: 2));

  final Map<int, List<Map<String, dynamic>>> _evidenceFiles = {};
  final List<String> _deletedEvidenceFiles = [];

  String _selectedEvidenceType = 'image';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _notesFocusNode = FocusNode();
    _dateController.text =
        "${_pickedDate.day}-${_pickedDate.month}-${_pickedDate.year}";

    _initializeForm();
  }

  void _initializeForm() {
    _checkupStore.getInfractions();

    _notesController.text = widget.checkup.notes ?? "";
    _formStore.setCheckupNotes(widget.checkup.notes ?? "");
    _formStore.setEntreprise_id(widget.checkup.entreprise_id ?? 0);
    _formStore.setCheckupCode(widget.checkup.code ?? '');

    if (widget.checkup.checkupInfractions != null) {
      for (var infraction
          in widget.checkup.checkupInfractions!.checkup_infractions!) {
        if (infraction.infraction_id != null) {
          _formStore.checkupInfractionIds[infraction.infraction_id!] =
              infraction.id;
          _formStore.selectedInfractions[infraction.infraction_id!] = true;
          _formStore.infractionNotes[infraction.infraction_id!] =
              infraction.notes ?? '';

          if (infraction.evidence_files != null) {
            _evidenceFiles[infraction.infraction_id!] =
                List<Map<String, dynamic>>.from(infraction
                        .evidence_files?.evidences
                        ?.map((e) => e.toMap())
                        .toList() ??
                    []);
          }
        } else {
          final evidenceFiles = [];
          if (infraction.evidence_files != null) {
            infraction.evidence_files!.evidences!.forEach((e) {
              evidenceFiles.add({
                'file_path': e.file_path,
                'file_type': e.file_type,
                'description': e.description,
              });
            });
          }

          _formStore.customInfractions.add({
            'id': infraction.id,
            'text': infraction.custom_infraction_text ?? "",
            'notes': infraction.notes ?? "",
            'evidence_files': evidenceFiles,
          });
        }
      }
    }
  }

  Widget _buildStatusField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            final res = await DialogUtils.buildSelectEnumDialog(
              context: context,
              title: AppLocalizations.of(context)
                  .translate('checkups_select_checkup_status'),
              values: CheckupStatusTypes.values,
              selected: _formStore.checkupStatus,
            );
            if (res != null) {
              _statusController.text =
                  AppLocalizations.of(context).translate(res);
              _formStore.setCheckupStatus(res);
            }
          },
          child: TextFieldRoundedWidget(
            hint: AppLocalizations.of(context)
                .translate('checkups_select_checkup_status'),
            inputType: TextInputType.text,
            // iconColor: Theme.of(context).iconTheme.,
            textController: _statusController,
            inputAction: TextInputAction.next,
            enabled: false,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setCheckupStatus(_statusController.text);
            },
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_notesFocusNode);
            },
            errorText: _formStore.formErrorStore.checkupStatus,
          ),
        );
      },
    );
  }

  Widget _buildInfractionField() {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          AppLocalizations.of(context).translate('checkups_select_infractions'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ..._buildInfractionsList(),
        Text(
          '${_formStore.formErrorStore.selectedInfractions ?? ''}',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        ..._buildCustomInfractionsList(),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text(AppLocalizations.of(context)
              .translate('checkups_other_infractions')),
          onPressed: () {
            setState(() {
              _formStore.customInfractions.add({
                'text': '',
                'notes': '',
                'id': null,
              });
            });
          },
        ),
      ],
    );
  }

  List<Widget> _buildInfractionsList() {
    Map<int, FieldData> fields = {};
    return _checkupStore.infractionsList?.infractions == null
        ? []
        : _checkupStore.infractionsList!.infractions!.map((infraction) {
            final id = infraction.id!;
            fields[id] = FieldData(_formStore.infractionNotes[id] ?? '');
            return Observer(builder: (context) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                          infraction.label ??
                              AppLocalizations.of(context)
                                  .translate('checkups_no_label'),
                        ),
                        value: _formStore.selectedInfractions[id] ?? false,
                        onChanged: (bool? value) {
                          if (value == false) {
                            setState(() {
                              _formStore.selectedInfractions.remove(id);
                              _formStore.infractionNotes.remove(id);
                            });
                          } else {
                            setState(() {
                              _formStore.selectedInfractions[id] = value!;
                            });
                          }
                        },
                      ),
                      if (_formStore.selectedInfractions[id] ?? false)
                        TextField(
                          controller: fields[id]!.controller,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)
                                .translate('checkups_aditional_notes'),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _formStore.infractionNotes[id] = value;
                            });
                          },
                        ),
                      if (_formStore.selectedInfractions[id] ?? false) ...[
                        SizedBox(height: 8),
                        if (_evidenceFiles[id] != null &&
                            (_evidenceFiles[id]?.isNotEmpty ?? false))
                          Column(
                            children: [
                              Text('Evidence Files:'),
                              ..._evidenceFiles[id]!
                                  .map((evidence) => ListTile(
                                        leading: Icon(_getEvidenceIcon(
                                            evidence['file_type'])),
                                        title: Text(evidence['description'] ??
                                            'No description'),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              if (evidence['file_path'] !=
                                                      null &&
                                                  evidence['file_path']
                                                      .isNotEmpty) {
                                                _deletedEvidenceFiles
                                                    .add(evidence['file_path']);
                                              }
                                              _evidenceFiles[id]
                                                  ?.remove(evidence);
                                            });
                                          },
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        SizedBox(height: 8),
                        ElevatedButton.icon(
                          icon: Icon(Icons.add_a_photo),
                          label: Text('Add Evidence'),
                          onPressed: () async {
                            final source =
                                await DialogUtils.buildImagePickerDialog(
                                    context);
                            if (source != null) {
                              // Get file from source
                              final file =
                                  await ImagePicker().pickImage(source: source);
                              if (file != null) {
                                // Get description
                                final description =
                                    await _showDescriptionDialog(context);

                                if (description != null) {
                                  
                                  setState(() {
                                    _evidenceFiles[id] ??= [];
                                    _evidenceFiles[id]!.add({
                                      'file': File(file.path),
                                      'file_type': _selectedEvidenceType,
                                      'description': description,
                                    });
                                  });
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            });
          }).toList();
  }

  List<Widget> _buildCustomInfractionsList() {
    Map<String, List<FieldData>> fields = {};
    fields['text'] = [];
    fields['notes'] = [];
    return _formStore.customInfractions.asMap().entries.map((entry) {
      final index = entry.key;
      fields['text']!
          .add(FieldData(_formStore.customInfractions[index]['text']));
      fields['notes']!
          .add(FieldData(_formStore.customInfractions[index]['notes']));
      return Observer(builder: (context) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TextField(
                        controller: fields['text']![index].controller,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)
                              .translate('checkups_infraction_label'),
                          border: OutlineInputBorder(),
                          errorText:
                              _formStore.formErrorStore.customInfractions,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _formStore.customInfractions[index]['text'] = value;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: fields['notes']![index].controller,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)
                              .translate('checkups_aditional_notes'),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _formStore.customInfractions[index]['notes'] =
                                value;
                          });
                        },
                      ),
                      if (_formStore.customInfractions[index]
                                  ['evidence_files'] !=
                              null &&
                          (_formStore.customInfractions[index]['evidence_files']
                                  ?.isNotEmpty ??
                              false))
                        Column(
                          children: [
                            Text('Evidence Files:'),
                            ..._formStore.customInfractions[index]
                                    ['evidence_files']
                                .map((evidence) => ListTile(
                                      leading: Icon(_getEvidenceIcon(
                                          evidence['file_type'])),
                                      title: Text(evidence['description'] ??
                                          'No description'),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            if (evidence['file_path'] != null &&
                                                evidence['file_path']
                                                    .isNotEmpty) {
                                              _deletedEvidenceFiles
                                                  .add(evidence['file_path']);
                                            }
                                            _formStore.customInfractions[index]
                                                    ['evidence_files']
                                                ?.remove(evidence);
                                          });
                                        },
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      SizedBox(height: 8),
                      ElevatedButton.icon(
                        icon: Icon(Icons.add_a_photo),
                        label: Text('Add Evidence'),
                        onPressed: () async {
                          final source =
                              await DialogUtils.buildImagePickerDialog(context);
                          if (source != null) {
                            final file =
                                await ImagePicker().pickImage(source: source);
                            if (file != null) {
                              final description =
                                  await _showDescriptionDialog(context);
                              if (description != null) {
                                setState(() {
                                  _formStore.customInfractions[index]
                                      ['evidence_files'] ??= [];
                                  _formStore.customInfractions[index]
                                          ['evidence_files']
                                      .add({
                                    'file': File(file.path),
                                    'file_type': _selectedEvidenceType,
                                    'description': description,
                                  });
                                });
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _formStore.customInfractions.removeAt(index);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      });
    }).toList();
  }

  Widget _buildActionField() {
    return Observer(
      builder: (context) {
        return _formStore.selectedInfractions.isEmpty &&
                _formStore.customInfractions.isEmpty
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: () async {
                  final res = await DialogUtils.buildSelectEnumDialog(
                    context: context,
                    title: AppLocalizations.of(context)
                        .translate('checkups_select_taken_action'),
                    values: CheckupActionTypes.values,
                    selected: _formStore.actionTaken,
                  );
                  if (res != null) {
                    _actionController.text =
                        AppLocalizations.of(context).translate(res);
                    _formStore.setActionTaken(res);
                  }
                },
                child: TextFieldRoundedWidget(
                  hint: AppLocalizations.of(context)
                      .translate('checkups_select_taken_action'),
                  inputType: TextInputType.text,
                  // iconColor: Theme.of(context).iconTheme.color,
                  textController: _actionController,
                  inputAction: TextInputAction.next,
                  enabled: false,
                  autoFocus: false,
                  onChanged: (value) {
                    _formStore.setActionTaken(_actionController.text);
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_notesFocusNode);
                  },
                  errorText: _formStore.formErrorStore.actionTaken,
                ),
              );
      },
    );
  }

  Widget _buildDueDateField() {
    return Observer(
      builder: (context) {
        return _formStore.selectedInfractions.isEmpty &&
                _formStore.customInfractions.isEmpty
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 2)),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 14)),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _pickedDate = pickedDate;
                      _dateController.text =
                          "${_pickedDate.day}-${_pickedDate.month}-${_pickedDate.year}";
                    });
                  }
                },
                child: TextFieldRoundedWidget(
                  hint: AppLocalizations.of(context)
                      .translate('checkups_select_duedate'),
                  inputType: TextInputType.text,
                  // iconColor: Theme.of(context).iconTheme.color,
                  textController: _dateController,
                  inputAction: TextInputAction.next,
                  enabled: false,
                  autoFocus: false,
                  onChanged: (value) {},
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_notesFocusNode);
                  },
                  errorText: _formStore.formErrorStore.actionTaken,
                ),
              );
      },
    );
  }

  Widget _buildNotesField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('checkups_enter_notes'),
          inputType: TextInputType.text,
          // iconColor: Theme.of(context).iconTheme.color,
          textController: _notesController,
          inputAction: TextInputAction.next,
          focusNode: _notesFocusNode,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setCheckupNotes(_notesController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_notesFocusNode);
          },
          errorText: _formStore.formErrorStore.checkupNotes,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: <Widget>[
          _buildMainContent(),
          Observer(
            builder: (context) {
              return _checkupStore.success
                  ? navigate(context)
                  : _showErrorMessage(_checkupStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _checkupStore.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title:
          Text(AppLocalizations.of(context).translate('checkups_add_checkup')),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () async {
            final confirm = await DialogUtils.buildActionDialog(
              context: context,
              title: 'Cancel Checkup',
              msg: 'Are you sure ?',
              confirmBtnText:
                  AppLocalizations.of(context).translate('general_yes'),
              cancelBtnText:
                  AppLocalizations.of(context).translate('general_no'),
            );

            if (confirm == true) {
              try {
                await _checkupStore.cancelCheckup(
                    checkupId: widget.checkup.id!);
                Navigator.pop(context);
              } catch (e) {
                _showErrorMessage(e.toString());
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Observer(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).translate('checkups_current_entreprise')}: ',
                    ),
                    if (widget.checkup.entreprise != null) ...[
                      Text(
                          '${widget.checkup.entreprise?.name} - ${widget.checkup.entreprise?.code}'),
                      Icon(Icons.check_circle_outline, color: Colors.green),
                    ],
                  ],
                ),
                SizedBox(height: 12),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (widget.checkup.code != null) ...[
                      Icon(Icons.content_paste_outlined, color: Colors.grey),
                      Text('${widget.checkup.code}'),
                    ],
                  ],
                ),

                // SizedBox(height: 12),
                // _buildStatusField(),

                SizedBox(height: 12),
                _buildInfractionField(),
                SizedBox(height: 12),
                _buildActionField(),
                SizedBox(height: 12),
                _buildDueDateField(),

                SizedBox(height: 12),
                _buildNotesField(),
                SizedBox(height: 24),

                _buildActionButtons(),
                // _buildSaveButton(),
                SizedBox(height: 12),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: RoundedButtonWidget(
            buttonText: 'save_progress',
            buttonColor: Colors.grey,
            textColor: Colors.white,
            enabled: widget.checkup.entreprise != null &&
                widget.checkup.code != null,
            onPressed: () async {
              if (widget.checkup.entreprise == null) {
                _showErrorMessage(AppLocalizations.of(context)
                    .translate('checkups_entreprise_not_set'));
                return;
              }

              DeviceUtils.hideKeyboard(context);
              try {
                final infractions = _formStore.selectedInfractions.entries
                    .where((e) => e.value)
                    .map((e) {
                  final evidenceFiles = _evidenceFiles[e.key]
                          ?.map((evidence) => {
                                'file': evidence['file'],
                                'file_path': evidence['file_path'],
                                'file_type': evidence['file_type'],
                                'description': evidence['description'],
                              })
                          .toList() ??
                      [];

                  return {
                    'infraction_id': e.key,
                    'id': _formStore.checkupInfractionIds[e.key],
                    'notes': _formStore.infractionNotes[e.key] ?? '',
                    'evidence_files': evidenceFiles
                  };
                }).toList();

                await _checkupStore.saveCheckupProgress(
                  checkupId: widget.checkup.id!,
                  notes: _formStore.checkupNotes,
                  infractions: infractions,
                  custom_infractions: _formStore.customInfractions,
                  deleted_evidence_files: _deletedEvidenceFiles,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('checkups_progress_saved'),
                  ),
                );
              } catch (e) {
                _showErrorMessage(e.toString());
              }
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: RoundedButtonWidget(
            buttonText: 'submit',
            buttonColor: Colors.orangeAccent,
            textColor: Colors.white,
            enabled: widget.checkup.entreprise != null &&
                widget.checkup.code != null,
            onPressed: () async {
              if (widget.checkup.entreprise == null) {
                _showErrorMessage(AppLocalizations.of(context)
                    .translate('checkups_entreprise_not_set'));
                return;
              }

              _formStore.validateCheckup();
              if (_formStore.canSaveCheckup) {
                DeviceUtils.hideKeyboard(context);
                try {
                  // final infractions = _formStore.selectedInfractions.entries
                  //     .where((e) => e.value)
                  //     .map((e) => {
                  //           'id': e.key,
                  //           'notes': _formStore.infractionNotes[e.key] ?? '',
                  //           'evidence_files': _evidenceFiles[e.key] ?? [],
                  //         })
                  //     .toList();

                  // final customInfractions = _formStore.customInfractions
                  //     .where((inf) => inf['text']?.isNotEmpty ?? false)
                  //     .map((inf) => {
                  //           'text': inf['text'],
                  //           'notes': inf['notes'] ?? '',
                  //         })
                  //     .toList();
                  final infractions = _formStore.selectedInfractions.entries
                      .where((e) => e.value)
                      .map((e) {
                    final evidenceFiles = _evidenceFiles[e.key]
                            ?.map((evidence) => {
                                  'file': evidence['file'],
                                  'file_path': evidence['file_path'],
                                  'file_type': evidence['file_type'],
                                  'description': evidence['description'],
                                })
                            .toList() ??
                        [];

                    return {
                      'infraction_id': e.key,
                      'id': _formStore.checkupInfractionIds[e.key],
                      'notes': _formStore.infractionNotes[e.key] ?? '',
                      'evidence_files': evidenceFiles
                    };
                  }).toList();

                  await _checkupStore
                      .submitCheckup(
                    checkupId: widget.checkup.id!,
                    infractions: infractions,
                    custom_infractions: _formStore.customInfractions,
                    deleted_evidence_files: _deletedEvidenceFiles,
                    notes: _formStore.checkupNotes,
                    duedate: DateTime.parse(
                        "${_pickedDate.year}-${_pickedDate.month.toString().padLeft(2, '0')}-${_pickedDate.day.toString().padLeft(2, '0')}"),
                    action_taken: (infractions.isEmpty && _formStore.customInfractions.isEmpty) ? 'none' : _formStore.actionTaken,
                  )
                      .then((res) {
                    if (_checkupStore.currentCheckup?.summon != null) {
                      _checkupStore.getMyCheckups();
                      _checkupStore.currentCheckup?.summon?.entreprise =
                          widget.checkup.entreprise;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => SummonDetailsScreen(
                              summon: _checkupStore.currentCheckup?.summon ??
                                  Summon())));
                    } else {
                      Navigator.pop(context);
                    }
                  });
                } catch (e) {
                  _showErrorMessage(e.toString());
                }
              } else {
                _showErrorMessage(AppLocalizations.of(context)
                    .translate('checkups_data_incomplete'));
              }
            },
          ),
        ),
      ],
    );
  }

  IconData _getEvidenceIcon(String? type) {
    switch (type) {
      case 'image':
        return Icons.image;
      case 'document':
        return Icons.description;
      case 'audio':
        return Icons.audio_file;
      case 'video':
        return Icons.video_file;
      default:
        return Icons.attach_file;
    }
  }

  Future<String?> _showDescriptionDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Evidence Description'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter description (optional)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      // Navigation logic if needed
    });

    return Container();
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('general_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  @override
  void dispose() {
    _statusController.dispose();
    _actionController.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }
}

class FieldData {
  String value;
  TextEditingController controller;

  FieldData(this.value) : controller = TextEditingController(text: value);
}
