import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/login/store/phone_auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SmsCodeInputPage extends StatelessWidget {
  final PhoneAuthStore store = getIt<PhoneAuthStore>();

  SmsCodeInputPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _codeController.text = store.smsCode ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter SMS Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) => Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'SMS Code',
                  ),
                  validator: (value) => store.validateSmsCode(value),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: store.isVerifyingCode
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            store.verifySmsCode(_codeController.text, context);
                          }
                        },
                  child: store.isVerifyingCode
                      ? CircularProgressIndicator()
                      : Text('Verify Code'),
                ),
                if (store.errorMessage != null) ...[
                  SizedBox(height: 16),
                  Text(
                    store.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}