import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/login/store/phone_auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PhoneNumberInputPage extends StatelessWidget {
  final PhoneAuthStore store = getIt<PhoneAuthStore>();

  PhoneNumberInputPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) => Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '42424242',
                  ),
                  validator: (value) => store.validatePhoneNumber(value),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: store.isSendingCode
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            store.verifyPhoneNumber(_phoneController.text, context);
                          }
                        },
                  child: store.isSendingCode
                      ? CircularProgressIndicator()
                      : Text('Send Code'),
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