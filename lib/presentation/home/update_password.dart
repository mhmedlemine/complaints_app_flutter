import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
import 'package:complaintsapp/presentation/home/store/language/language_store.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen>
    with TickerProviderStateMixin {
  //text controllers:-----------------------------------------------------------
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newPasswordConfirmationController =
      TextEditingController();

  bool _showPassword = false;
  bool _showNewPassword = false;

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;
  late FocusNode _newPasswordFocusNode;
  late FocusNode _newPasswordConfirmationFocusNode;

  //stores:---------------------------------------------------------------------
  //final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _newPasswordConfirmationFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // appbar methods:--------------------------------------------------------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
      elevation: 0,
      title: Text(
        '${AppLocalizations.of(context).translate('update_password_update_password')}',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: [],
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          _buildResetPasswordContents(),
          // Observer(
          //   builder: (context) {
          //     return _store.success
          //         ? navigate(context)
          //         : _showErrorMessage(_store.errorStore.errorMessage);
          //   },
          // ),
          // Observer(
          //   builder: (context) {
          //     // return Visibility(
          //     //   visible: _userStore.isUpdatingPassword,
          //     //   child: CustomProgressIndicatorWidget(),
          //     // );
          //   },
          // )
        ],
      ),
    );
  }

  Widget _buildResetPasswordContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildPasswordField(),
            _buildNewPasswordField(),
            _buildNewPasswordConfirmationField(),
            SizedBox(height: 20.0),
            _buildResetPasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint:
              '${AppLocalizations.of(context).translate('update_password_current_password')}',
          isObscure: !_showPassword,
          maxLines: 1,
          padding: EdgeInsets.only(top: 16.0),
          iconColor: Colors.black54,
          textController: _passwordController,
          inputAction: TextInputAction.next,
          errorText: null,//_store.formErrorStore.password,
          focusNode: _passwordFocusNode,
          suffix: InkWell(
            onTap: () => setState(() {
              _showPassword = !_showPassword;
            }),
            child: Icon(
              _showPassword ? FontAwesome5.eye_slash : FontAwesome5.eye,
              size: 18,
            ),
          ),
          onChanged: (value) {
            //_store.setPassword(_passwordController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_newPasswordFocusNode);
          },
        );
      },
    );
  }

  Widget _buildNewPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint:
              '${AppLocalizations.of(context).translate('update_password_new_password')}',
          isObscure: !_showNewPassword,
          maxLines: 1,
          padding: EdgeInsets.only(top: 16.0),
          iconColor: Colors.black54,
          textController: _newPasswordController,
          inputAction: TextInputAction.next,
          errorText: null,//_store.formErrorStore.newPassword,
          focusNode: _newPasswordFocusNode,
          onChanged: (value) {
            //_store.setNewPassword(_newPasswordController.text);
          },
        );
      },
    );
  }

  Widget _buildNewPasswordConfirmationField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint:
              '${AppLocalizations.of(context).translate('update_password_retype_new_password')}',
          isObscure: !_showNewPassword,
          maxLines: 1,
          padding: EdgeInsets.only(top: 16.0),
          iconColor: Colors.black54,
          suffix: InkWell(
            onTap: () => setState(() {
              _showNewPassword = !_showNewPassword;
            }),
            child: Icon(
              _showNewPassword ? FontAwesome5.eye_slash : FontAwesome5.eye,
              size: 18,
            ),
          ),
          textController: _newPasswordConfirmationController,
          focusNode: _newPasswordConfirmationFocusNode,
          inputAction: TextInputAction.done,
          errorText: null,//_store.formErrorStore.confirmNewPassword,
          onChanged: (value) {
            // _store
            //     .setConfirmNewPassword(_newPasswordConfirmationController.text);
          },
        );
      },
    );
  }

  Widget _buildResetPasswordButton() {
    return RoundedButtonWidget(
      buttonText: AppLocalizations.of(context).translate('general_ok'),
      buttonColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.onPrimary,
      onPressed: () async {
        //_store.validateAll();
        // if (_store.canUpdatePassword) {
        //   DeviceUtils.hideKeyboard(context);
        //   _userStore
        //       .updatePassword(
        //         password: _passwordController.text,
        //         newPassword: _newPasswordController.text,
        //         confirmPassword: _newPasswordConfirmationController.text,
        //       )
        //       .then((_) => navigate())
        //       .catchError(
        //         (_) => _showErrorMessage(_userStore.errorStore.errorMessage),
        //       );
        // } else {
        //   _showErrorMessage(
        //     AppLocalizations.of(context).translate('signup_error_fill_fields'),
        //   );
        // }
      },
    );
  }

  Widget navigate() {
    // Fluttertoast.showToast(
    //   msg:
    //       "${AppLocalizations.of(context).translate('update_password_password_updated_successfuly')}",
    //   toastLength: Toast.LENGTH_SHORT,
    //   textColor: Colors.white,
    //   backgroundColor: Colors.green,
    //   gravity: ToastGravity.TOP,
    // );

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pop();
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
            title: AppLocalizations.of(context).translate('general_error'),
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
    _passwordController.dispose();
    _newPasswordConfirmationController.dispose();
    _passwordFocusNode.dispose();
    _newPasswordConfirmationFocusNode.dispose();
    super.dispose();
  }
}
