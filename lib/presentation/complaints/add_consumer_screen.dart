import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/core/widgets/rounded_button_widget.dart';
import 'package:complaintsapp/core/widgets/textfield_round_widget.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddConsumerScreen extends StatefulWidget {
  final String phoneNumber;

  const AddConsumerScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _AddConsumerScreenState createState() => _AddConsumerScreenState();
}

class _AddConsumerScreenState extends State<AddConsumerScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nniController = TextEditingController();
  final _addressController = TextEditingController();

  final FormStore _formStore = getIt<FormStore>();
  final CheckupStore _checkupStore = getIt<CheckupStore>();

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.phoneNumber;
    _formStore.setConsumerPhone(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('consumers_add_consumer'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildFNameField(),
                SizedBox(height: 16),
                _buildLNameField(),
                SizedBox(height: 16),
                _buildPhoneField(),
                SizedBox(height: 16),
                _buildNNIField(),
                SizedBox(height: 16),
                _buildAddressField(),
                SizedBox(height: 24),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _checkupStore.loading || _checkupStore.loadingConsumer,
              child: CustomProgressIndicatorWidget(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFNameField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'consumers_enter_firstname',
          textController: _fnameController,
          onChanged: (value) => _formStore.setConsumerFName(value),
          errorText: _formStore.formErrorStore.consumerFName,
        );
      }
    );
  }

  Widget _buildLNameField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'consumers_enter_lastname',
          textController: _lnameController,
          onChanged: (value) => _formStore.setConsumerLName(value),
          errorText: _formStore.formErrorStore.consumerLName,
        );
      }
    );
  }

  Widget _buildPhoneField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'consumers_enter_phone',
          textController: _phoneController,
          inputType: TextInputType.phone,
          enabled: false,
          onChanged: (value) => _formStore.setConsumerPhone(value),
          errorText: _formStore.formErrorStore.consumerPhone,
        );
      }
    );
  }

  Widget _buildNNIField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'consumers_enter_nni',
          textController: _nniController,
          inputType: TextInputType.number,
          onChanged: (value) => _formStore.setConsumerNNI(value),
          errorText: _formStore.formErrorStore.consumerNNI,
        );
      }
    );
  }

  Widget _buildAddressField() {
    return Observer(
      builder: (context) {
        return TextFieldRoundedWidget(
          hint: 'consumers_enter_address',
          textController: _addressController,
          onChanged: (value) => _formStore.setConsumerAddress(value),
          errorText: _formStore.formErrorStore.consumerAddress,
        );
      }
    );
  }

  Widget _buildSubmitButton() {
    return Row(
      children: [
        Expanded(
          child: RoundedButtonWidget(
            buttonText: 'general_submit',
            buttonColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () async {
              _formStore.validateConsumer();
              if (_formStore.canSaveConsumer) {
                DeviceUtils.hideKeyboard(context);
                try {
                  final consumer = Consumer(
                    nni: _nniController.text,
                    fname: _fnameController.text,
                    lname: _lnameController.text,
                    phonenumber: _phoneController.text,
                    address: _addressController.text,
                  );
                  final result = await _checkupStore.addConsumer(consumer);
                  Navigator.of(context).pop(result);
                } catch (e) {
                  _showErrorMessage(e.toString());
                }
              } else {
                _showErrorMessage(
                  'form_incomplete',
                );
              }
            },
          ),
        ),
      ],
    );
  }

  void _showErrorMessage(String message) {
    FlushbarHelper.createError(
      message: message,
      title: 'general_error',
      duration: Duration(seconds: 3),
    )..show(context);
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    _nniController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
