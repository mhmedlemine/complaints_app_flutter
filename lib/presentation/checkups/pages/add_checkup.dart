// import 'package:another_flushbar/flushbar_helper.dart';
// import 'package:complaintsapp/constants/strings.dart';
// import 'package:complaintsapp/core/domain/enums.dart';
// import 'package:complaintsapp/core/services/location_service.dart';
// import 'package:complaintsapp/core/stores/form/form_store.dart';
// import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
// import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
// import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
// import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
// import 'package:complaintsapp/presentation/checkups/pages/summon_details.dart';
// import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
// import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
// import 'package:complaintsapp/presentation/login/store/login_store.dart';
// import 'package:complaintsapp/presentation/shop/add_entreprise.dart';
// import 'package:complaintsapp/utils/device/device_utils.dart';
// import 'package:complaintsapp/utils/dialogs/dialog_utils.dart';
// import 'package:complaintsapp/utils/locale/app_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:intl/intl.dart';

// import '../../../di/service_locator.dart';

// class AddCheckupScreen extends StatefulWidget {
//   @override
//   _AddCheckupScreenState createState() => _AddCheckupScreenState();
// }

// class _AddCheckupScreenState extends State<AddCheckupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final LocationService _locationService = LocationService();
//   //text controllers:-----------------------------------------------------------
//   final _statusController = TextEditingController(text: AppLocalizations.instance.translate('clean'));
//   final _actionController = TextEditingController(text: AppLocalizations.instance.translate('none'));
//   final _notesController = TextEditingController();
//   final _dateController = TextEditingController();

//   //stores:---------------------------------------------------------------------
//   final ThemeStore _themeStore = getIt<ThemeStore>();
//   final FormStore _formStore = getIt<FormStore>();
//   final UserStore _userStore = getIt<UserStore>();

//   //focus node:-----------------------------------------------------------------
//   late FocusNode _notesFocusNode;

//   //stores:---------------------------------------------------------------------
//   final CheckupStore _checkupStore = getIt<CheckupStore>();

//   String _checkupType = 'regular';
//   DateTime _pickedDate = DateTime.now().add(Duration(days: 2));

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//     _dateController.text =
//         "${_pickedDate.day}-${_pickedDate.month}-${_pickedDate.year}";
//     _notesFocusNode = FocusNode();
//   }

//   Future<void> _getCurrentLocation() async {
//     _checkupStore.getInfractions();
//     final position = await _locationService.getCurrentPosition();
//     if (position != null) {
//       await _checkupStore.getEntreprise(position.latitude, position.longitude);
//       if (_checkupStore.entreprise == null) {
//         final res = await DialogUtils.buildActionDialog(
//           context: context,
//           confirmBtnText: "Add Shop",
//           cancelBtnText: "Cancel",
//           title: "Shop not found",
//           msg: "There is no shop at this location. Do you want to add it ?",
//         );
//         if (res == true) {
//           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => AddEntrepriseScreen()));
//         } else {
//           Navigator.of(context).pop();
//         }
//       } else {
//         _formStore.setEntreprise_id(_checkupStore.entreprise?.id ?? 0);
//         _formStore.setCheckupCode(
//             'CTRL-REG-${_checkupStore.entreprise!.code}-${_userStore.user?.phonenumber}-${DateFormat('dd-MM-yy-HH:mm').format(DateTime.now())}');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       primary: true,
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }

//   // app bar methods:-----------------------------------------------------------
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       title:
//           Text(AppLocalizations.of(context).translate('checkups_add_checkup')),
//       actions: _buildActions(context),
//     );
//   }

//   List<Widget> _buildActions(BuildContext context) {
//     return <Widget>[];
//   }

//   // body methods:--------------------------------------------------------------
//   Widget _buildBody() {
//     return Stack(
//       children: <Widget>[
//         Center(child: _buildMainContent()),
//         Observer(
//           builder: (context) {
//             return _checkupStore.success
//                 ? navigate(context)
//                 : _showErrorMessage(_checkupStore.errorStore.errorMessage);
//           },
//         ),
//         Observer(
//           builder: (context) {
//             return Visibility(
//               visible: _checkupStore.loading || _checkupStore.addingCheckup,
//               child: CustomProgressIndicatorWidget(),
//             );
//           },
//         )
//       ],
//     );
//   }

//   Widget _buildMainContent() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Observer(builder: (context) {
//           return Column(
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//                   Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                       children: [
//                         Text(
//                             '${AppLocalizations.of(context).translate('checkups_current_entreprise')}: ',
//                             ),
//                         if (_checkupStore.entreprise != null) ...[
//                           Text('${_checkupStore.entreprise?.name} - ${_checkupStore.entreprise?.code}'),
//                           Icon(Icons.check_circle_outline, color: Colors.green),
//                         ] else ... [
//                           SizedBox(width: 12),
//                           SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2)),
//                         ],
//                       ],
//                     ),
//               SizedBox(height: 12),
//               Wrap(
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                       children: [
//                         if (_formStore.checkupCode.isNotEmpty) ...[
//                           Icon(Icons.content_paste_outlined, color: Colors.grey),
//                           Text('${_formStore.checkupCode}'),
//                         ] else ... [
//                           Text(
//                             '${AppLocalizations.of(context).translate('checkups_generating_code')}..',
//                           ),
//                           SizedBox(width: 12),
//                           SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2)),
//                         ],
//                       ],
//                     ),

//               SizedBox(height: 12),
//               _buildStatusField(),
//               if (_formStore.checkupStatus == 'with_infractions') ...[
//                 SizedBox(height: 12),
//                 _buildInfractionField(),
//                 SizedBox(height: 12),
//                 _buildActionField(),
//                 SizedBox(height: 12),
//                 _buildDueDateField(),
//               ],
//               SizedBox(height: 12),
//               _buildNotesField(),
//               SizedBox(height: 12),
//               _buildSaveButton(),
//               SizedBox(height: 12),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildStatusField() {
//     return Observer(
//       builder: (context) {
//         return GestureDetector(
//           onTap: () async {
//             final res = await DialogUtils.buildSelectEnumDialog(
//               context: context,
//               title: AppLocalizations.of(context)
//                   .translate('checkups_select_checkup_status'),
//               values: CheckupStatusTypes.values,
//               selected: _formStore.checkupStatus,
//             );
//             if (res != null) {
//               _statusController.text = AppLocalizations.of(context)
//                 .translate(res);
//               _formStore.setCheckupStatus(res);
//             }
//           },
//           child: TextFieldRoundedWidget(
//             hint: AppLocalizations.of(context)
//                 .translate('checkups_select_checkup_status'),
//             inputType: TextInputType.text,
//             //icon: Icons.person,
//             iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
//             textController: _statusController,
//             inputAction: TextInputAction.next,
//             enabled: false,
//             autoFocus: false,
//             onChanged: (value) {
//               _formStore.setCheckupStatus(_statusController.text);
//             },
//             onFieldSubmitted: (value) {
//               FocusScope.of(context).requestFocus(_notesFocusNode);
//             },
//             errorText: _formStore.formErrorStore.checkupStatus,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildInfractionField() {
//     return Column(
//       children: [
//         SizedBox(height: 16),
//         Text(
//           AppLocalizations.of(context).translate('checkups_select_infractions'),
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         ..._buildInfractionsList(),
//         Text(
//           '${_formStore.formErrorStore.selectedInfractions ?? ''}',
//           style: TextStyle(color: Theme.of(context).colorScheme.error),
//         ),
//         ..._buildCustomInfractionsList(),
//         ElevatedButton.icon(
//           icon: Icon(Icons.add),
//           label: Text(AppLocalizations.of(context)
//               .translate('checkups_other_infractions')),
//           onPressed: _addCustomInfraction,
//         ),
//       ],
//     );
//   }

//   void _addCustomInfraction() {
//     setState(() {
//       _formStore.customInfractions.add({'text': '', 'notes': ''});
//     });
//   }

//   List<Widget> _buildInfractionsList() {
//     return _checkupStore.infractionsList?.infractions == null
//         ? []
//         : _checkupStore.infractionsList!.infractions!.map((infraction) {
//             final id = infraction.id as int;
//             return Observer(builder: (context) {
//               return Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Column(
//                     children: [
//                       CheckboxListTile(
//                         title: Text(
//                           infraction.label ??
//                               AppLocalizations.of(context)
//                                   .translate('checkups_no_label'),
//                         ),
//                         value: _formStore.selectedInfractions[id] ?? false,
//                         onChanged: (bool? value) {
//                           if (value == false) {
//                             setState(() {
//                               _formStore.selectedInfractions.remove(id);
//                               _formStore.infractionNotes.remove(id);
//                             });
//                           } else {
//                             setState(() {
//                               _formStore.selectedInfractions[id] = value!;
//                             });
//                           }
//                         },
//                       ),
//                       if (_formStore.selectedInfractions[id] ?? false)
//                         TextField(
//                           decoration: InputDecoration(
//                             labelText: AppLocalizations.of(context)
//                                 .translate('checkups_aditional_notes'),
//                             border: OutlineInputBorder(),
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               _formStore.infractionNotes[id] = value;
//                             });
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//           }).toList();
//   }

//   List<Widget> _buildCustomInfractionsList() {
//     return _formStore.customInfractions.asMap().entries.map((entry) {
//       final index = entry.key;
//       return Observer(builder: (context) {
//         return Card(
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .7,
//                   child: Column(
//                     children: [
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: AppLocalizations.of(context)
//                               .translate('checkups_infraction_label'),
//                           border: OutlineInputBorder(),
//                           errorText: _formStore.formErrorStore.customInfractions,
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             _formStore.customInfractions[index]['text'] = value;
//                           });
//                         },
//                       ),
//                       SizedBox(height: 8),
//                       TextField(
//                         decoration: InputDecoration(
//                           labelText: AppLocalizations.of(context)
//                               .translate('checkups_aditional_notes'),
//                           border: OutlineInputBorder(),
//                         ),
//                         onChanged: (value) {
//                           setState(() {
//                             _formStore.customInfractions[index]['notes'] = value;
//                           });
//                         },
//                       ),
//                       // TextButton(
//                       //   onPressed: () {
//                       //     setState(() {
//                       //       _formStore.customInfractions.removeAt(index);
//                       //     });
//                       //   },
//                       //   child: Text(
//                       //       AppLocalizations.of(context).translate('checkups_remove'),
//                       //       style: TextStyle(color: Colors.red)),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * .08,
//                   child: IconButton(onPressed: () {
//                     setState(() {
//                       _formStore.customInfractions.removeAt(index);
//                     });
//                   }, icon: Icon(Icons.delete)),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
//     }).toList();
//   }

//   Widget _buildActionField() {
//     return Observer(
//       builder: (context) {
//         return GestureDetector(
//           onTap: () async {
//             final res = await DialogUtils.buildSelectEnumDialog(
//               context: context,
//               title: AppLocalizations.of(context)
//                   .translate('checkups_select_taken_action'),
//               values: CheckupActionTypes.values,
//               selected: _formStore.actionTaken,
//             );
//             if (res != null) {
//               _actionController.text = AppLocalizations.of(context).translate(res);
//               _formStore.setActionTaken(res);
//             }
//           },
//           child: TextFieldRoundedWidget(
//             hint: AppLocalizations.of(context)
//                 .translate('checkups_select_taken_action'),
//             inputType: TextInputType.text,
//             //icon: Icons.person,
//             iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
//             textController: _actionController,
//             inputAction: TextInputAction.next,
//             enabled: false,
//             autoFocus: false,
//             onChanged: (value) {
//               _formStore.setActionTaken(_actionController.text);
//             },
//             onFieldSubmitted: (value) {
//               FocusScope.of(context).requestFocus(_notesFocusNode);
//             },
//             errorText: _formStore.formErrorStore.actionTaken,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDueDateField() {
//     return Observer(
//       builder: (context) {
//         return GestureDetector(
//           onTap: () async {
//             final pickedDate = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now().add(Duration(days: 2)),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.now().add(Duration(days: 14)),
//             );

//             if (pickedDate != null) {
//               setState(() {
//                 _pickedDate = pickedDate;
//                 _dateController.text =
//                     "${_pickedDate.day}-${_pickedDate.month}-${_pickedDate.year}";
//               });
//             }
//           },
//           child: TextFieldRoundedWidget(
//             hint: AppLocalizations.of(context)
//                 .translate('checkups_select_duedate'),
//             inputType: TextInputType.text,
//             //icon: Icons.person,
//             iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
//             textController: _dateController,
//             inputAction: TextInputAction.next,
//             enabled: false,
//             autoFocus: false,
//             onChanged: (value) {},
//             onFieldSubmitted: (value) {
//               FocusScope.of(context).requestFocus(_notesFocusNode);
//             },
//             errorText: _formStore.formErrorStore.actionTaken,
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildNotesField() {
//     return Observer(
//       builder: (context) {
//         return TextFieldRoundedWidget(
//           hint: AppLocalizations.of(context).translate('checkups_enter_notes'),
//           inputType: TextInputType.text,
//           //icon: Icons.person,
//           iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
//           textController: _notesController,
//           inputAction: TextInputAction.next,
//           autoFocus: false,
//           onChanged: (value) {
//             _formStore.setCheckupNotes(_notesController.text);
//           },
//           onFieldSubmitted: (value) {
//             FocusScope.of(context).requestFocus(_notesFocusNode);
//           },
//           errorText: _formStore.formErrorStore.checkupNotes,
//         );
//       },
//     );
//   }

//   Widget _buildSaveButton() {
//     return RoundedButtonWidget(
//       buttonText: AppLocalizations.of(context).translate('checkups_add'),
//       buttonColor: (_checkupStore.entreprise == null || _formStore.checkupCode.isEmpty) ? Colors.grey : Colors.orangeAccent,
//       textColor: Colors.white,
//       enabled: _checkupStore.entreprise != null && _formStore.checkupCode.isNotEmpty,
//       onPressed: () async {
//         if (_checkupStore.entreprise == null) {
//           _showErrorMessage(AppLocalizations.of(context)
//               .translate('checkups_entreprise_not_set'));
//           return;
//         }
//         _formStore.validateCheckup();
//         if (_formStore.canSaveCheckup) {
//           DeviceUtils.hideKeyboard(context);
//           try {
//             final data = AddCheckupParams(
//               code: _formStore.checkupCode,
//               entreprise_id: _formStore.entreprise_id,
//               type: _checkupType,
//               status: _formStore.checkupStatus,
//               action_taken: _formStore.actionTaken,
//               notes: _formStore.checkupNotes,
//               duedate: DateTime.parse(
//                 "${_pickedDate.year}-${_pickedDate.month.toString().padLeft(2, '0')}-${_pickedDate.day.toString().padLeft(2, '0')}"
//               ),
//               infractions: _formStore.selectedInfractions.entries
//                   .where((e) => e.value)
//                   .map((e) => {
//                         'id': e.key,
//                         'notes': _formStore.infractionNotes[e.key] ?? '',
//                       })
//                   .toList(),
//               custom_infractions: _formStore.customInfractions,
//             );

//             await _checkupStore.addCheckup(data).then((res) {
//               if (data.status == 'with_infractions') {
//                 _checkupStore.getMyCheckups();
//                 res.entreprise = _checkupStore.entreprise;
//                 Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (_) => SummonDetailsScreen(summon: res)));
//               } else {
//                 Navigator.of(context).pop();
//               }
//             }).catchError((error) {});
//           } catch (e) {}
//         } else {
//           _showErrorMessage(AppLocalizations.of(context)
//               .translate('checkups_data_incomplete'));
//         }
//       },
//     );
//   }

//   Widget navigate(BuildContext context) {
//     Future.delayed(Duration(milliseconds: 0), () {
//       //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => EntrepriseListScreen()));
//     });

//     return Container();
//   }

//   // General Methods:-----------------------------------------------------------
//   _showErrorMessage(String message) {
//     if (message.isNotEmpty) {
//       Future.delayed(Duration(milliseconds: 0), () {
//         if (message.isNotEmpty) {
//           FlushbarHelper.createError(
//             message: message,
//             title: AppLocalizations.of(context).translate('general_error'),
//             duration: Duration(seconds: 3),
//           )..show(context);
//         }
//       });
//     }

//     return SizedBox.shrink();
//   }

//   // dispose:-------------------------------------------------------------------
//   @override
//   void dispose() {
//     // Clean up the controller when the Widget is removed from the Widget tree
//     _statusController.dispose();
//     _actionController.dispose();
//     _notesFocusNode.dispose();
//     super.dispose();
//   }
// }
