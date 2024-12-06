import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/presentation/complaints/consumer_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:another_flushbar/flushbar_helper.dart';

class ComplaintFormScreen extends StatefulWidget {
  @override
  _ComplaintFormScreenState createState() => _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends State<ComplaintFormScreen> {
  // Controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _greenNumberController = TextEditingController();
  final _shopAddressController = TextEditingController();
  final _consumerController = TextEditingController();

  // Focus nodes
  late FocusNode _descriptionFocusNode;

  // Stores
  final FormStore _formStore = getIt<FormStore>();
  final CheckupStore _checkupStore = getIt<CheckupStore>();

  Consumer? _selectedConsumer;

  @override
  void initState() {
    super.initState();
    _descriptionFocusNode = FocusNode();
    _checkupStore.getInfractions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('complaints_file_complaint'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildTitleField(),
              SizedBox(height: 16),
              _buildDescriptionField(),
              SizedBox(height: 16),
              _buildGreenNumberField(),
              SizedBox(height: 16),
              _buildShopAddressField(),
              SizedBox(height: 16),
              _buildConsumerField(),
              SizedBox(height: 16),
              _buildInfractionsField(),
              SizedBox(height: 24),
              _buildSubmitButton(),
            ],
          ),
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _checkupStore.loading || _checkupStore.loadingComplaints,
              child: CustomProgressIndicatorWidget(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTitleField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'complaints_enter_title',
          textController: _titleController,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            _formStore.setComplaintTitle(value);
          },
          errorText: _formStore.formErrorStore.complaintTitle,
        );
      },
    );
  }

  Widget _buildDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'complaints_enter_description',
          textController: _descriptionController,
          inputAction: TextInputAction.newline,
          maxLines: 4,
          focusNode: _descriptionFocusNode,
          onChanged: (value) {
            _formStore.setComplaintDescription(value);
          },
          errorText: _formStore.formErrorStore.complaintDescription,
        );
      },
    );
  }

  Widget _buildGreenNumberField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'complaints_enter_green_number',
          textController: _greenNumberController,
          inputType: TextInputType.phone,
          onChanged: (value) {
            _formStore.setGreenNumber(value);
          },
          errorText: _formStore.formErrorStore.greenNumber,
        );
      },
    );
  }

  Widget _buildShopAddressField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'complaints_enter_shop_address',
          textController: _shopAddressController,
          onChanged: (value) {
            _formStore.setShopAddress(value);
          },
          errorText: _formStore.formErrorStore.shopAddress,
        );
      },
    );
  }

  Widget _buildConsumerField() {
    return Observer(
      builder: (context) {
        return GestureDetector(
          onTap: () async {
            final Consumer? res = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ConsumerSearchScreen(
                  hintTxt: 'complaints_enter_consumer_number',
                ),
              ),
            );

            if (res != null) {
              setState(() {
                _selectedConsumer = res;
                _consumerController.text = '${res.fname} ${res.lname}';
                _formStore.setConsumerId(res.id ?? 0);
              });
            }
          },
          child: TextFieldRoundedWidget(
            hint: 'complaints_select_consumer',
            textController: _consumerController,
            enabled: false,
            errorText: _formStore.formErrorStore.consumerId,
          ),
        );
      },
    );
  }

  Widget _buildInfractionsField() {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          AppLocalizations.of(context).translate('checkups_select_infractions'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ..._buildInfractionsLists(),
        Text(
          '${_formStore.formErrorStore.selectedInfractions ?? ''}',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
        ..._buildCustomInfractionsLists(),
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

  List<Widget> _buildInfractionsLists() {
    return _checkupStore.infractionsList?.infractions == null
        ? []
        : _checkupStore.infractionsList!.infractions!.map((infraction) {
            final id = infraction.id!;
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
                    ],
                  ),
                ),
              );
            });
          }).toList();
  }

  List<Widget> _buildCustomInfractionsLists() {
    return _formStore.customInfractions.asMap().entries.map((entry) {
      final index = entry.key;
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

  Widget _buildInfractionField() {
    return Column(
      children: [
        Text(
          'complaints_select_infractions',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ..._buildInfractionsList(),
        ..._buildCustomInfractionsList(),
        ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('complaints_other_infractions'),
          onPressed: () {
            setState(() {
              _formStore.customInfractions.add({
                'text': '',
                'notes': '',
              });
            });
          },
        ),
      ],
    );
  }

  List<Widget> _buildInfractionsList() {
    return _checkupStore.infractionsList?.infractions?.map((infraction) {
          final id = infraction.id!;
          return Observer(
            builder: (context) {
              return Card(
                child: CheckboxListTile(
                  title: Text(infraction.label ?? ''),
                  value: _formStore.selectedInfractions[id] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _formStore.selectedInfractions[id] = true;
                      } else {
                        _formStore.selectedInfractions.remove(id);
                      }
                    });
                  },
                  subtitle: _formStore.selectedInfractions[id] == true
                      ? TextField(
                          decoration: InputDecoration(
                            labelText: 'complaints_additional_notes',
                          ),
                          onChanged: (value) {
                            _formStore.infractionNotes[id] = value;
                          },
                        )
                      : null,
                ),
              );
            },
          );
        }).toList() ??
        [];
  }

  List<Widget> _buildCustomInfractionsList() {
    return _formStore.customInfractions.asMap().entries.map((entry) {
      final index = entry.key;
      return Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'complaints_infraction_description',
                ),
                onChanged: (value) {
                  setState(() {
                    _formStore.customInfractions[index]['text'] = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'complaints_additional_notes',
                ),
                onChanged: (value) {
                  setState(() {
                    _formStore.customInfractions[index]['notes'] = value;
                  });
                },
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
    }).toList();
  }

  Widget _buildSubmitButton() {
    return Row(
      children: [
        Expanded(
          child: RoundedButtonWidget(
            buttonText: 'complaints_submit',
            buttonColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () async {
              _formStore.validateComplaintForm();
              if (_formStore.canSubmitComplaint) {
                DeviceUtils.hideKeyboard(context);
                try {
                  await _checkupStore.submitComplaint(
                    title: _formStore.complaintTitle,
                    description: _formStore.complaintDescription,
                    greenNumber: _formStore.greenNumber,
                    consumerId: _formStore.consumerId,
                    shopAddress: _formStore.shopAddress,
                    selectedInfractions: _formStore.selectedInfractions,
                    infractionNotes: _formStore.infractionNotes,
                    customInfractions: _formStore.customInfractions,
                  );
                  Navigator.of(context).pop();
                } catch (e) {
                  _showErrorMessage(e.toString());
                }
              } else {
                _showErrorMessage(
                  'complaints_form_incomplete',
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      FlushbarHelper.createError(
        message: message,
        title: 'general_error',
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _greenNumberController.dispose();
    _shopAddressController.dispose();
    _consumerController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
}
