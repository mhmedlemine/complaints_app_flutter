import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/core/widgets/app_icon_widget.dart';
import 'package:complaintsapp/core/widgets/empty_app_bar_widget.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_widget.dart';
import 'package:complaintsapp/data/sharedpref/constants/preferences.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:complaintsapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class AddComplaintScreen extends StatefulWidget {
  @override
  _AddComplaintScreenState createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userPhoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Ajouter Plainte'),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
    ];
  }



  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Center(child: _buildMainContent()),
        Observer(
          builder: (context) {
            return _userStore.success
                ? navigate(context)
                : _showErrorMessage(_userStore.errorStore.errorMessage);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _userStore.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildGreenNumberField(),
            _buildTitleField(),
            _buildDescriptionField(),
            _buildConsumerField(),
            _buildTitleField(),
            _buildEntrepriseField(),
            _buildTypeField(),
            _buildAddressField(),
            _buildSaveButton()
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Titre',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }
  
  Widget _buildDescriptionField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Description',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildGreenNumberField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Numero Vert',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildConsumerField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Consomateur',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildTypeField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Type',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildEntrepriseField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Societé',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildAddressField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          hint: 'Adresse',
          inputType: TextInputType.phone,
          icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _userPhoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _formStore.setUserId(_userPhoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return RoundedButtonWidget(
      buttonText: 'Ajouter',
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () async {
        if (_formStore.canLogin) {
          DeviceUtils.hideKeyboard(context);
          _userStore.login(_userPhoneController.text, _passwordController.text);
        } else {
          _showErrorMessage('Entrer vos données');
        }
      },
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userPhoneController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}