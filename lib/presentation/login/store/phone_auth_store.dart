import 'package:complaintsapp/presentation/login/widgets/sms_code_input_page.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'phone_auth_store.g.dart';

class PhoneAuthStore = _PhoneAuthStore with _$PhoneAuthStore;

abstract class _PhoneAuthStore with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  String? verificationId;

  @observable
  bool isSendingCode = false;

  @observable
  bool isVerifyingCode = false;

  @observable
  String? errorMessage;

  @observable
  String? smsCode;

  @action
  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+\d{7,15}$').hasMatch(value)) {
      return 'Enter phone number with country code, e.g., +1234567890';
    }
    return null;
  }

  @action
  String? validateSmsCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'SMS code is required';
    }
    if (value.length < 6) {
      return 'Enter a valid 6-digit code';
    }
    return null;
  }

  @action
  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) async {
    isSendingCode = true;
    errorMessage = null;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification
          await _auth.signInWithCredential(credential);
          // Navigate to home or desired page
          Navigator.of(context).pushReplacementNamed('/home');
        },
        verificationFailed: (FirebaseAuthException e) {
          errorMessage = e.message;
        },
        codeSent: (String verId, int? resendToken) {
          verificationId = verId;
          smsCode = null;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SmsCodeInputPage()),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isSendingCode = false;
    }
  }

  @action
  Future<void> verifySmsCode(String code, BuildContext context) async {
    isVerifyingCode = true;
    errorMessage = null;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: code,
      );
      await _auth.signInWithCredential(credential);
      // Navigate to home or desired page
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } finally {
      isVerifyingCode = false;
    }
  }
}