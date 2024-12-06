import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
import 'package:complaintsapp/data/sharedpref/constants/preferences.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/presentation/shop/search.dart';
import 'package:complaintsapp/presentation/shop/store/shop_store.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/dialogs/dialog_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:complaintsapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class AddMerchantScreen extends StatefulWidget {
  final String phoneNumber;

  const AddMerchantScreen({super.key, required this.phoneNumber});

  @override
  _AddMerchantScreenState createState() => _AddMerchantScreenState();
}

class _AddMerchantScreenState extends State<AddMerchantScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nniController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final ShopStore _shopStore = getIt<ShopStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phoneNumber;
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
      title: Text(AppLocalizations.of(context).translate('shops_add_owner')),
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
              visible: _shopStore.addingMerchant,
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
            _buildfnameField(),
            SizedBox(height: 12),
            _buildlnameField(),
            SizedBox(height: 12),
            _buildPhoneField(),
            SizedBox(height: 12),
            _buildNNIField(),
            SizedBox(height: 12),
            _buildSaveButton(),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildfnameField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_firstname'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _fnameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            // _formStore.setUserId(_fnameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildlnameField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_lastname'),
          inputType: TextInputType.text,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _lnameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            //_formStore.setUserId(_lnameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }

  Widget _buildPhoneField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_phone_number'),
          inputType: TextInputType.phone,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _phoneController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            //_formStore.setUserId(_phoneController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          errorText: _formStore.formErrorStore.phoneNumber,
        );
      },
    );
  }


  Widget _buildNNIField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: AppLocalizations.of(context).translate('shops_enter_nni'),
          inputType: TextInputType.number,
          //icon: Icons.person,
          iconColor: _themeStore.darkMode ? Colors.white70 : Colors.black54,
          textController: _nniController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            //_formStore.setUserId _nniController.text);
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
      buttonText: AppLocalizations.of(context).translate('shops_add'),
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () async {
        if (_fnameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
          DeviceUtils.hideKeyboard(context);
          final merchant = Merchant(
            nni: _nniController.text,
            fname: _fnameController.text,
            lname: _lnameController.text,
            phoneNumber: _phoneController.text,
          );
          try {
            final res = await _shopStore.addMerchant(merchant);
            Navigator.of(context).pop(res);
          } catch(e) {

          }
        } else {
          _showErrorMessage(AppLocalizations.of(context).translate('shops_data_incomplete'));
        }
      },
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     Routes.home, (Route<dynamic> route) => false);
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
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _nniController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}