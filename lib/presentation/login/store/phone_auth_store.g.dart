// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PhoneAuthStore on _PhoneAuthStore, Store {
  late final _$verificationIdAtom =
      Atom(name: '_PhoneAuthStore.verificationId', context: context);

  @override
  String? get verificationId {
    _$verificationIdAtom.reportRead();
    return super.verificationId;
  }

  @override
  set verificationId(String? value) {
    _$verificationIdAtom.reportWrite(value, super.verificationId, () {
      super.verificationId = value;
    });
  }

  late final _$isSendingCodeAtom =
      Atom(name: '_PhoneAuthStore.isSendingCode', context: context);

  @override
  bool get isSendingCode {
    _$isSendingCodeAtom.reportRead();
    return super.isSendingCode;
  }

  @override
  set isSendingCode(bool value) {
    _$isSendingCodeAtom.reportWrite(value, super.isSendingCode, () {
      super.isSendingCode = value;
    });
  }

  late final _$isVerifyingCodeAtom =
      Atom(name: '_PhoneAuthStore.isVerifyingCode', context: context);

  @override
  bool get isVerifyingCode {
    _$isVerifyingCodeAtom.reportRead();
    return super.isVerifyingCode;
  }

  @override
  set isVerifyingCode(bool value) {
    _$isVerifyingCodeAtom.reportWrite(value, super.isVerifyingCode, () {
      super.isVerifyingCode = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_PhoneAuthStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$smsCodeAtom =
      Atom(name: '_PhoneAuthStore.smsCode', context: context);

  @override
  String? get smsCode {
    _$smsCodeAtom.reportRead();
    return super.smsCode;
  }

  @override
  set smsCode(String? value) {
    _$smsCodeAtom.reportWrite(value, super.smsCode, () {
      super.smsCode = value;
    });
  }

  late final _$verifyPhoneNumberAsyncAction =
      AsyncAction('_PhoneAuthStore.verifyPhoneNumber', context: context);

  @override
  Future<void> verifyPhoneNumber(String phoneNumber, BuildContext context) {
    return _$verifyPhoneNumberAsyncAction
        .run(() => super.verifyPhoneNumber(phoneNumber, context));
  }

  late final _$verifySmsCodeAsyncAction =
      AsyncAction('_PhoneAuthStore.verifySmsCode', context: context);

  @override
  Future<void> verifySmsCode(String code, BuildContext context) {
    return _$verifySmsCodeAsyncAction
        .run(() => super.verifySmsCode(code, context));
  }

  late final _$_PhoneAuthStoreActionController =
      ActionController(name: '_PhoneAuthStore', context: context);

  @override
  String? validatePhoneNumber(String? value) {
    final _$actionInfo = _$_PhoneAuthStoreActionController.startAction(
        name: '_PhoneAuthStore.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(value);
    } finally {
      _$_PhoneAuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? validateSmsCode(String? value) {
    final _$actionInfo = _$_PhoneAuthStoreActionController.startAction(
        name: '_PhoneAuthStore.validateSmsCode');
    try {
      return super.validateSmsCode(value);
    } finally {
      _$_PhoneAuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
verificationId: ${verificationId},
isSendingCode: ${isSendingCode},
isVerifyingCode: ${isVerifyingCode},
errorMessage: ${errorMessage},
smsCode: ${smsCode}
    ''';
  }
}
