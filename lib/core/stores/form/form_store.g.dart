// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormStore on _FormStore, Store {
  Computed<bool>? _$canSubmitComplaintComputed;

  @override
  bool get canSubmitComplaint => (_$canSubmitComplaintComputed ??=
          Computed<bool>(() => super.canSubmitComplaint,
              name: '_FormStore.canSubmitComplaint'))
      .value;
  Computed<bool>? _$canSaveConsumerComputed;

  @override
  bool get canSaveConsumer =>
      (_$canSaveConsumerComputed ??= Computed<bool>(() => super.canSaveConsumer,
              name: '_FormStore.canSaveConsumer'))
          .value;
  Computed<bool>? _$canSaveEntrepriseComputed;

  @override
  bool get canSaveEntreprise => (_$canSaveEntrepriseComputed ??= Computed<bool>(
          () => super.canSaveEntreprise,
          name: '_FormStore.canSaveEntreprise'))
      .value;
  Computed<bool>? _$canSaveCheckupComputed;

  @override
  bool get canSaveCheckup =>
      (_$canSaveCheckupComputed ??= Computed<bool>(() => super.canSaveCheckup,
              name: '_FormStore.canSaveCheckup'))
          .value;
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;
  Computed<bool>? _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
          .value;
  Computed<bool>? _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_FormStore.canForgetPassword'))
      .value;

  late final _$complaintTitleAtom =
      Atom(name: '_FormStore.complaintTitle', context: context);

  @override
  String get complaintTitle {
    _$complaintTitleAtom.reportRead();
    return super.complaintTitle;
  }

  @override
  set complaintTitle(String value) {
    _$complaintTitleAtom.reportWrite(value, super.complaintTitle, () {
      super.complaintTitle = value;
    });
  }

  late final _$complaintDescriptionAtom =
      Atom(name: '_FormStore.complaintDescription', context: context);

  @override
  String get complaintDescription {
    _$complaintDescriptionAtom.reportRead();
    return super.complaintDescription;
  }

  @override
  set complaintDescription(String value) {
    _$complaintDescriptionAtom.reportWrite(value, super.complaintDescription,
        () {
      super.complaintDescription = value;
    });
  }

  late final _$greenNumberAtom =
      Atom(name: '_FormStore.greenNumber', context: context);

  @override
  String get greenNumber {
    _$greenNumberAtom.reportRead();
    return super.greenNumber;
  }

  @override
  set greenNumber(String value) {
    _$greenNumberAtom.reportWrite(value, super.greenNumber, () {
      super.greenNumber = value;
    });
  }

  late final _$consumerIdAtom =
      Atom(name: '_FormStore.consumerId', context: context);

  @override
  int get consumerId {
    _$consumerIdAtom.reportRead();
    return super.consumerId;
  }

  @override
  set consumerId(int value) {
    _$consumerIdAtom.reportWrite(value, super.consumerId, () {
      super.consumerId = value;
    });
  }

  late final _$shopAddressAtom =
      Atom(name: '_FormStore.shopAddress', context: context);

  @override
  String get shopAddress {
    _$shopAddressAtom.reportRead();
    return super.shopAddress;
  }

  @override
  set shopAddress(String value) {
    _$shopAddressAtom.reportWrite(value, super.shopAddress, () {
      super.shopAddress = value;
    });
  }

  late final _$consumerFNameAtom =
      Atom(name: '_FormStore.consumerFName', context: context);

  @override
  String get consumerFName {
    _$consumerFNameAtom.reportRead();
    return super.consumerFName;
  }

  @override
  set consumerFName(String value) {
    _$consumerFNameAtom.reportWrite(value, super.consumerFName, () {
      super.consumerFName = value;
    });
  }

  late final _$consumerLNameAtom =
      Atom(name: '_FormStore.consumerLName', context: context);

  @override
  String get consumerLName {
    _$consumerLNameAtom.reportRead();
    return super.consumerLName;
  }

  @override
  set consumerLName(String value) {
    _$consumerLNameAtom.reportWrite(value, super.consumerLName, () {
      super.consumerLName = value;
    });
  }

  late final _$consumerPhoneAtom =
      Atom(name: '_FormStore.consumerPhone', context: context);

  @override
  String get consumerPhone {
    _$consumerPhoneAtom.reportRead();
    return super.consumerPhone;
  }

  @override
  set consumerPhone(String value) {
    _$consumerPhoneAtom.reportWrite(value, super.consumerPhone, () {
      super.consumerPhone = value;
    });
  }

  late final _$consumerNNIAtom =
      Atom(name: '_FormStore.consumerNNI', context: context);

  @override
  String get consumerNNI {
    _$consumerNNIAtom.reportRead();
    return super.consumerNNI;
  }

  @override
  set consumerNNI(String value) {
    _$consumerNNIAtom.reportWrite(value, super.consumerNNI, () {
      super.consumerNNI = value;
    });
  }

  late final _$consumerAddressAtom =
      Atom(name: '_FormStore.consumerAddress', context: context);

  @override
  String get consumerAddress {
    _$consumerAddressAtom.reportRead();
    return super.consumerAddress;
  }

  @override
  set consumerAddress(String value) {
    _$consumerAddressAtom.reportWrite(value, super.consumerAddress, () {
      super.consumerAddress = value;
    });
  }

  late final _$codeAtom = Atom(name: '_FormStore.code', context: context);

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$nameAtom = Atom(name: '_FormStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$moughataa_idAtom =
      Atom(name: '_FormStore.moughataa_id', context: context);

  @override
  int get moughataa_id {
    _$moughataa_idAtom.reportRead();
    return super.moughataa_id;
  }

  @override
  set moughataa_id(int value) {
    _$moughataa_idAtom.reportWrite(value, super.moughataa_id, () {
      super.moughataa_id = value;
    });
  }

  late final _$owner_idAtom =
      Atom(name: '_FormStore.owner_id', context: context);

  @override
  int get owner_id {
    _$owner_idAtom.reportRead();
    return super.owner_id;
  }

  @override
  set owner_id(int value) {
    _$owner_idAtom.reportWrite(value, super.owner_id, () {
      super.owner_id = value;
    });
  }

  late final _$latAtom = Atom(name: '_FormStore.lat', context: context);

  @override
  double get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(double value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  late final _$lonAtom = Atom(name: '_FormStore.lon', context: context);

  @override
  double get lon {
    _$lonAtom.reportRead();
    return super.lon;
  }

  @override
  set lon(double value) {
    _$lonAtom.reportWrite(value, super.lon, () {
      super.lon = value;
    });
  }

  late final _$neighbourhoodAtom =
      Atom(name: '_FormStore.neighbourhood', context: context);

  @override
  String get neighbourhood {
    _$neighbourhoodAtom.reportRead();
    return super.neighbourhood;
  }

  @override
  set neighbourhood(String value) {
    _$neighbourhoodAtom.reportWrite(value, super.neighbourhood, () {
      super.neighbourhood = value;
    });
  }

  late final _$addressAtom = Atom(name: '_FormStore.address', context: context);

  @override
  String get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$typeAtom = Atom(name: '_FormStore.type', context: context);

  @override
  String get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$rgAtom = Atom(name: '_FormStore.rg', context: context);

  @override
  String get rg {
    _$rgAtom.reportRead();
    return super.rg;
  }

  @override
  set rg(String value) {
    _$rgAtom.reportWrite(value, super.rg, () {
      super.rg = value;
    });
  }

  late final _$notesAtom = Atom(name: '_FormStore.notes', context: context);

  @override
  String get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(String value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$checkupCodeAtom =
      Atom(name: '_FormStore.checkupCode', context: context);

  @override
  String get checkupCode {
    _$checkupCodeAtom.reportRead();
    return super.checkupCode;
  }

  @override
  set checkupCode(String value) {
    _$checkupCodeAtom.reportWrite(value, super.checkupCode, () {
      super.checkupCode = value;
    });
  }

  late final _$checkupStatusAtom =
      Atom(name: '_FormStore.checkupStatus', context: context);

  @override
  String get checkupStatus {
    _$checkupStatusAtom.reportRead();
    return super.checkupStatus;
  }

  @override
  set checkupStatus(String value) {
    _$checkupStatusAtom.reportWrite(value, super.checkupStatus, () {
      super.checkupStatus = value;
    });
  }

  late final _$actionTakenAtom =
      Atom(name: '_FormStore.actionTaken', context: context);

  @override
  String get actionTaken {
    _$actionTakenAtom.reportRead();
    return super.actionTaken;
  }

  @override
  set actionTaken(String value) {
    _$actionTakenAtom.reportWrite(value, super.actionTaken, () {
      super.actionTaken = value;
    });
  }

  late final _$entreprise_idAtom =
      Atom(name: '_FormStore.entreprise_id', context: context);

  @override
  int get entreprise_id {
    _$entreprise_idAtom.reportRead();
    return super.entreprise_id;
  }

  @override
  set entreprise_id(int value) {
    _$entreprise_idAtom.reportWrite(value, super.entreprise_id, () {
      super.entreprise_id = value;
    });
  }

  late final _$checkupNotesAtom =
      Atom(name: '_FormStore.checkupNotes', context: context);

  @override
  String get checkupNotes {
    _$checkupNotesAtom.reportRead();
    return super.checkupNotes;
  }

  @override
  set checkupNotes(String value) {
    _$checkupNotesAtom.reportWrite(value, super.checkupNotes, () {
      super.checkupNotes = value;
    });
  }

  late final _$selectedInfractionsAtom =
      Atom(name: '_FormStore.selectedInfractions', context: context);

  @override
  Map<int, bool> get selectedInfractions {
    _$selectedInfractionsAtom.reportRead();
    return super.selectedInfractions;
  }

  @override
  set selectedInfractions(Map<int, bool> value) {
    _$selectedInfractionsAtom.reportWrite(value, super.selectedInfractions, () {
      super.selectedInfractions = value;
    });
  }

  late final _$infractionNotesAtom =
      Atom(name: '_FormStore.infractionNotes', context: context);

  @override
  Map<int, String> get infractionNotes {
    _$infractionNotesAtom.reportRead();
    return super.infractionNotes;
  }

  @override
  set infractionNotes(Map<int, String> value) {
    _$infractionNotesAtom.reportWrite(value, super.infractionNotes, () {
      super.infractionNotes = value;
    });
  }

  late final _$checkupInfractionIdsAtom =
      Atom(name: '_FormStore.checkupInfractionIds', context: context);

  @override
  Map<int, int?> get checkupInfractionIds {
    _$checkupInfractionIdsAtom.reportRead();
    return super.checkupInfractionIds;
  }

  @override
  set checkupInfractionIds(Map<int, int?> value) {
    _$checkupInfractionIdsAtom.reportWrite(value, super.checkupInfractionIds,
        () {
      super.checkupInfractionIds = value;
    });
  }

  late final _$customInfractionsAtom =
      Atom(name: '_FormStore.customInfractions', context: context);

  @override
  List<Map<String, dynamic>> get customInfractions {
    _$customInfractionsAtom.reportRead();
    return super.customInfractions;
  }

  @override
  set customInfractions(List<Map<String, dynamic>> value) {
    _$customInfractionsAtom.reportWrite(value, super.customInfractions, () {
      super.customInfractions = value;
    });
  }

  late final _$fnameAtom = Atom(name: '_FormStore.fname', context: context);

  @override
  String get fname {
    _$fnameAtom.reportRead();
    return super.fname;
  }

  @override
  set fname(String value) {
    _$fnameAtom.reportWrite(value, super.fname, () {
      super.fname = value;
    });
  }

  late final _$lnameAtom = Atom(name: '_FormStore.lname', context: context);

  @override
  String get lname {
    _$lnameAtom.reportRead();
    return super.lname;
  }

  @override
  set lname(String value) {
    _$lnameAtom.reportWrite(value, super.lname, () {
      super.lname = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_FormStore.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_FormStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_FormStore.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$successAtom = Atom(name: '_FormStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$_FormStoreActionController =
      ActionController(name: '_FormStore', context: context);

  @override
  void setComplaintTitle(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setComplaintTitle');
    try {
      return super.setComplaintTitle(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setComplaintDescription(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setComplaintDescription');
    try {
      return super.setComplaintDescription(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGreenNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setGreenNumber');
    try {
      return super.setGreenNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsumerId(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConsumerId');
    try {
      return super.setConsumerId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShopAddress(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setShopAddress');
    try {
      return super.setShopAddress(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateComplaintTitle(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateComplaintTitle');
    try {
      return super.validateComplaintTitle(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateComplaintDescription(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateComplaintDescription');
    try {
      return super.validateComplaintDescription(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateGreenNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateGreenNumber');
    try {
      return super.validateGreenNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConsumerId(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConsumerId');
    try {
      return super.validateConsumerId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateShopAddress(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateShopAddress');
    try {
      return super.validateShopAddress(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsumerFName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConsumerFName');
    try {
      return super.setConsumerFName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsumerLName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConsumerLName');
    try {
      return super.setConsumerLName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsumerPhone(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConsumerPhone');
    try {
      return super.setConsumerPhone(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsumerNNI(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConsumerNNI');
    try {
      return super.setConsumerNNI(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsumerAddress(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConsumerAddress');
    try {
      return super.setConsumerAddress(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConsumerFName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConsumerFName');
    try {
      return super.validateConsumerFName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConsumerLName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConsumerLName');
    try {
      return super.validateConsumerLName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConsumerPhone(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConsumerPhone');
    try {
      return super.validateConsumerPhone(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConsumerNNI(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConsumerNNI');
    try {
      return super.validateConsumerNNI(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConsumerAddress(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConsumerAddress');
    try {
      return super.validateConsumerAddress(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMoughataaId(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setMoughataaId');
    try {
      return super.setMoughataaId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setOwnerId(int value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setOwnerId');
    try {
      return super.setOwnerId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLat(double value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setLat');
    try {
      return super.setLat(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLon(double value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setLon');
    try {
      return super.setLon(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNeighbourhood(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setNeighbourhood');
    try {
      return super.setNeighbourhood(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAddress(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setAddress');
    try {
      return super.setAddress(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setType(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setType');
    try {
      return super.setType(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRg(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setRg');
    try {
      return super.setRg(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotes(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setNotes');
    try {
      return super.setNotes(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckupCode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setCheckupCode');
    try {
      return super.setCheckupCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckupStatus(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setCheckupStatus');
    try {
      return super.setCheckupStatus(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActionTaken(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setActionTaken');
    try {
      return super.setActionTaken(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEntreprise_id(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setEntreprise_id');
    try {
      return super.setEntreprise_id(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCheckupNotes(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setCheckupNotes');
    try {
      return super.setCheckupNotes(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedInfractions(Map<int, bool> value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setSelectedInfractions');
    try {
      return super.setSelectedInfractions(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setInfractionNotes(Map<int, String> value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setInfractionNotes');
    try {
      return super.setInfractionNotes(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCustomInfractions(List<Map<String, String>> value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setCustomInfractions');
    try {
      return super.setCustomInfractions(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserId(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhoneNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatecode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatecode');
    try {
      return super.validatecode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatename(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatename');
    try {
      return super.validatename(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatemoughataa_id(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatemoughataa_id');
    try {
      return super.validatemoughataa_id(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateowner_id(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateowner_id');
    try {
      return super.validateowner_id(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatelat(double value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatelat');
    try {
      return super.validatelat(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatelon(double value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatelon');
    try {
      return super.validatelon(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateneighbourhood(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateneighbourhood');
    try {
      return super.validateneighbourhood(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateaddress(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateaddress');
    try {
      return super.validateaddress(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatetype(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatetype');
    try {
      return super.validatetype(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validaterg(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.validaterg');
    try {
      return super.validaterg(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatenotes(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatenotes');
    try {
      return super.validatenotes(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCheckupCode(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCheckupCode');
    try {
      return super.validateCheckupCode(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCheckupStatus(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCheckupStatus');
    try {
      return super.validateCheckupStatus(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateActionTaken(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateActionTaken');
    try {
      return super.validateActionTaken(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEntreprise_id(int value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateEntreprise_id');
    try {
      return super.validateEntreprise_id(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCheckupNotes(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCheckupNotes');
    try {
      return super.validateCheckupNotes(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateSelectedInfractions(Map<int, bool> value, String statusValue) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateSelectedInfractions');
    try {
      return super.validateSelectedInfractions(value, statusValue);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateInfractionNotes(Map<int, String> value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateInfractionNotes');
    try {
      return super.validateInfractionNotes(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateCustomInfractions(List<Map<String, dynamic>> value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateCustomInfractions');
    try {
      return super.validateCustomInfractions(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
complaintTitle: ${complaintTitle},
complaintDescription: ${complaintDescription},
greenNumber: ${greenNumber},
consumerId: ${consumerId},
shopAddress: ${shopAddress},
consumerFName: ${consumerFName},
consumerLName: ${consumerLName},
consumerPhone: ${consumerPhone},
consumerNNI: ${consumerNNI},
consumerAddress: ${consumerAddress},
code: ${code},
name: ${name},
moughataa_id: ${moughataa_id},
owner_id: ${owner_id},
lat: ${lat},
lon: ${lon},
neighbourhood: ${neighbourhood},
address: ${address},
type: ${type},
rg: ${rg},
notes: ${notes},
checkupCode: ${checkupCode},
checkupStatus: ${checkupStatus},
actionTaken: ${actionTaken},
entreprise_id: ${entreprise_id},
checkupNotes: ${checkupNotes},
selectedInfractions: ${selectedInfractions},
infractionNotes: ${infractionNotes},
checkupInfractionIds: ${checkupInfractionIds},
customInfractions: ${customInfractions},
fname: ${fname},
lname: ${lname},
phoneNumber: ${phoneNumber},
password: ${password},
confirmPassword: ${confirmPassword},
success: ${success},
canSubmitComplaint: ${canSubmitComplaint},
canSaveConsumer: ${canSaveConsumer},
canSaveEntreprise: ${canSaveEntreprise},
canSaveCheckup: ${canSaveCheckup},
canLogin: ${canLogin},
canRegister: ${canRegister},
canForgetPassword: ${canForgetPassword}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool>? _$hasErrorsInAddEntrepriseComputed;

  @override
  bool get hasErrorsInAddEntreprise => (_$hasErrorsInAddEntrepriseComputed ??=
          Computed<bool>(() => super.hasErrorsInAddEntreprise,
              name: '_FormErrorStore.hasErrorsInAddEntreprise'))
      .value;
  Computed<bool>? _$hasErrorsInAddCheckupComputed;

  @override
  bool get hasErrorsInAddCheckup => (_$hasErrorsInAddCheckupComputed ??=
          Computed<bool>(() => super.hasErrorsInAddCheckup,
              name: '_FormErrorStore.hasErrorsInAddCheckup'))
      .value;
  Computed<bool>? _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool>? _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool>? _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;

  late final _$complaintTitleAtom =
      Atom(name: '_FormErrorStore.complaintTitle', context: context);

  @override
  String? get complaintTitle {
    _$complaintTitleAtom.reportRead();
    return super.complaintTitle;
  }

  @override
  set complaintTitle(String? value) {
    _$complaintTitleAtom.reportWrite(value, super.complaintTitle, () {
      super.complaintTitle = value;
    });
  }

  late final _$complaintDescriptionAtom =
      Atom(name: '_FormErrorStore.complaintDescription', context: context);

  @override
  String? get complaintDescription {
    _$complaintDescriptionAtom.reportRead();
    return super.complaintDescription;
  }

  @override
  set complaintDescription(String? value) {
    _$complaintDescriptionAtom.reportWrite(value, super.complaintDescription,
        () {
      super.complaintDescription = value;
    });
  }

  late final _$greenNumberAtom =
      Atom(name: '_FormErrorStore.greenNumber', context: context);

  @override
  String? get greenNumber {
    _$greenNumberAtom.reportRead();
    return super.greenNumber;
  }

  @override
  set greenNumber(String? value) {
    _$greenNumberAtom.reportWrite(value, super.greenNumber, () {
      super.greenNumber = value;
    });
  }

  late final _$consumerIdAtom =
      Atom(name: '_FormErrorStore.consumerId', context: context);

  @override
  String? get consumerId {
    _$consumerIdAtom.reportRead();
    return super.consumerId;
  }

  @override
  set consumerId(String? value) {
    _$consumerIdAtom.reportWrite(value, super.consumerId, () {
      super.consumerId = value;
    });
  }

  late final _$shopAddressAtom =
      Atom(name: '_FormErrorStore.shopAddress', context: context);

  @override
  String? get shopAddress {
    _$shopAddressAtom.reportRead();
    return super.shopAddress;
  }

  @override
  set shopAddress(String? value) {
    _$shopAddressAtom.reportWrite(value, super.shopAddress, () {
      super.shopAddress = value;
    });
  }

  late final _$consumerFNameAtom =
      Atom(name: '_FormErrorStore.consumerFName', context: context);

  @override
  String? get consumerFName {
    _$consumerFNameAtom.reportRead();
    return super.consumerFName;
  }

  @override
  set consumerFName(String? value) {
    _$consumerFNameAtom.reportWrite(value, super.consumerFName, () {
      super.consumerFName = value;
    });
  }

  late final _$consumerLNameAtom =
      Atom(name: '_FormErrorStore.consumerLName', context: context);

  @override
  String? get consumerLName {
    _$consumerLNameAtom.reportRead();
    return super.consumerLName;
  }

  @override
  set consumerLName(String? value) {
    _$consumerLNameAtom.reportWrite(value, super.consumerLName, () {
      super.consumerLName = value;
    });
  }

  late final _$consumerPhoneAtom =
      Atom(name: '_FormErrorStore.consumerPhone', context: context);

  @override
  String? get consumerPhone {
    _$consumerPhoneAtom.reportRead();
    return super.consumerPhone;
  }

  @override
  set consumerPhone(String? value) {
    _$consumerPhoneAtom.reportWrite(value, super.consumerPhone, () {
      super.consumerPhone = value;
    });
  }

  late final _$consumerNNIAtom =
      Atom(name: '_FormErrorStore.consumerNNI', context: context);

  @override
  String? get consumerNNI {
    _$consumerNNIAtom.reportRead();
    return super.consumerNNI;
  }

  @override
  set consumerNNI(String? value) {
    _$consumerNNIAtom.reportWrite(value, super.consumerNNI, () {
      super.consumerNNI = value;
    });
  }

  late final _$consumerAddressAtom =
      Atom(name: '_FormErrorStore.consumerAddress', context: context);

  @override
  String? get consumerAddress {
    _$consumerAddressAtom.reportRead();
    return super.consumerAddress;
  }

  @override
  set consumerAddress(String? value) {
    _$consumerAddressAtom.reportWrite(value, super.consumerAddress, () {
      super.consumerAddress = value;
    });
  }

  late final _$codeAtom = Atom(name: '_FormErrorStore.code', context: context);

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  late final _$nameAtom = Atom(name: '_FormErrorStore.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$moughataa_idAtom =
      Atom(name: '_FormErrorStore.moughataa_id', context: context);

  @override
  String? get moughataa_id {
    _$moughataa_idAtom.reportRead();
    return super.moughataa_id;
  }

  @override
  set moughataa_id(String? value) {
    _$moughataa_idAtom.reportWrite(value, super.moughataa_id, () {
      super.moughataa_id = value;
    });
  }

  late final _$owner_idAtom =
      Atom(name: '_FormErrorStore.owner_id', context: context);

  @override
  String? get owner_id {
    _$owner_idAtom.reportRead();
    return super.owner_id;
  }

  @override
  set owner_id(String? value) {
    _$owner_idAtom.reportWrite(value, super.owner_id, () {
      super.owner_id = value;
    });
  }

  late final _$latAtom = Atom(name: '_FormErrorStore.lat', context: context);

  @override
  String? get lat {
    _$latAtom.reportRead();
    return super.lat;
  }

  @override
  set lat(String? value) {
    _$latAtom.reportWrite(value, super.lat, () {
      super.lat = value;
    });
  }

  late final _$lonAtom = Atom(name: '_FormErrorStore.lon', context: context);

  @override
  String? get lon {
    _$lonAtom.reportRead();
    return super.lon;
  }

  @override
  set lon(String? value) {
    _$lonAtom.reportWrite(value, super.lon, () {
      super.lon = value;
    });
  }

  late final _$neighbourhoodAtom =
      Atom(name: '_FormErrorStore.neighbourhood', context: context);

  @override
  String? get neighbourhood {
    _$neighbourhoodAtom.reportRead();
    return super.neighbourhood;
  }

  @override
  set neighbourhood(String? value) {
    _$neighbourhoodAtom.reportWrite(value, super.neighbourhood, () {
      super.neighbourhood = value;
    });
  }

  late final _$addressAtom =
      Atom(name: '_FormErrorStore.address', context: context);

  @override
  String? get address {
    _$addressAtom.reportRead();
    return super.address;
  }

  @override
  set address(String? value) {
    _$addressAtom.reportWrite(value, super.address, () {
      super.address = value;
    });
  }

  late final _$typeAtom = Atom(name: '_FormErrorStore.type', context: context);

  @override
  String? get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String? value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  late final _$rgAtom = Atom(name: '_FormErrorStore.rg', context: context);

  @override
  String? get rg {
    _$rgAtom.reportRead();
    return super.rg;
  }

  @override
  set rg(String? value) {
    _$rgAtom.reportWrite(value, super.rg, () {
      super.rg = value;
    });
  }

  late final _$notesAtom =
      Atom(name: '_FormErrorStore.notes', context: context);

  @override
  String? get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(String? value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  late final _$checkupCodeAtom =
      Atom(name: '_FormErrorStore.checkupCode', context: context);

  @override
  String? get checkupCode {
    _$checkupCodeAtom.reportRead();
    return super.checkupCode;
  }

  @override
  set checkupCode(String? value) {
    _$checkupCodeAtom.reportWrite(value, super.checkupCode, () {
      super.checkupCode = value;
    });
  }

  late final _$checkupStatusAtom =
      Atom(name: '_FormErrorStore.checkupStatus', context: context);

  @override
  String? get checkupStatus {
    _$checkupStatusAtom.reportRead();
    return super.checkupStatus;
  }

  @override
  set checkupStatus(String? value) {
    _$checkupStatusAtom.reportWrite(value, super.checkupStatus, () {
      super.checkupStatus = value;
    });
  }

  late final _$actionTakenAtom =
      Atom(name: '_FormErrorStore.actionTaken', context: context);

  @override
  String? get actionTaken {
    _$actionTakenAtom.reportRead();
    return super.actionTaken;
  }

  @override
  set actionTaken(String? value) {
    _$actionTakenAtom.reportWrite(value, super.actionTaken, () {
      super.actionTaken = value;
    });
  }

  late final _$entreprise_idAtom =
      Atom(name: '_FormErrorStore.entreprise_id', context: context);

  @override
  String? get entreprise_id {
    _$entreprise_idAtom.reportRead();
    return super.entreprise_id;
  }

  @override
  set entreprise_id(String? value) {
    _$entreprise_idAtom.reportWrite(value, super.entreprise_id, () {
      super.entreprise_id = value;
    });
  }

  late final _$checkupNotesAtom =
      Atom(name: '_FormErrorStore.checkupNotes', context: context);

  @override
  String? get checkupNotes {
    _$checkupNotesAtom.reportRead();
    return super.checkupNotes;
  }

  @override
  set checkupNotes(String? value) {
    _$checkupNotesAtom.reportWrite(value, super.checkupNotes, () {
      super.checkupNotes = value;
    });
  }

  late final _$selectedInfractionsAtom =
      Atom(name: '_FormErrorStore.selectedInfractions', context: context);

  @override
  String? get selectedInfractions {
    _$selectedInfractionsAtom.reportRead();
    return super.selectedInfractions;
  }

  @override
  set selectedInfractions(String? value) {
    _$selectedInfractionsAtom.reportWrite(value, super.selectedInfractions, () {
      super.selectedInfractions = value;
    });
  }

  late final _$infractionNotesAtom =
      Atom(name: '_FormErrorStore.infractionNotes', context: context);

  @override
  String? get infractionNotes {
    _$infractionNotesAtom.reportRead();
    return super.infractionNotes;
  }

  @override
  set infractionNotes(String? value) {
    _$infractionNotesAtom.reportWrite(value, super.infractionNotes, () {
      super.infractionNotes = value;
    });
  }

  late final _$customInfractionsAtom =
      Atom(name: '_FormErrorStore.customInfractions', context: context);

  @override
  String? get customInfractions {
    _$customInfractionsAtom.reportRead();
    return super.customInfractions;
  }

  @override
  set customInfractions(String? value) {
    _$customInfractionsAtom.reportWrite(value, super.customInfractions, () {
      super.customInfractions = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_FormErrorStore.phoneNumber', context: context);

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_FormErrorStore.password', context: context);

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_FormErrorStore.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  @override
  String toString() {
    return '''
complaintTitle: ${complaintTitle},
complaintDescription: ${complaintDescription},
greenNumber: ${greenNumber},
consumerId: ${consumerId},
shopAddress: ${shopAddress},
consumerFName: ${consumerFName},
consumerLName: ${consumerLName},
consumerPhone: ${consumerPhone},
consumerNNI: ${consumerNNI},
consumerAddress: ${consumerAddress},
code: ${code},
name: ${name},
moughataa_id: ${moughataa_id},
owner_id: ${owner_id},
lat: ${lat},
lon: ${lon},
neighbourhood: ${neighbourhood},
address: ${address},
type: ${type},
rg: ${rg},
notes: ${notes},
checkupCode: ${checkupCode},
checkupStatus: ${checkupStatus},
actionTaken: ${actionTaken},
entreprise_id: ${entreprise_id},
checkupNotes: ${checkupNotes},
selectedInfractions: ${selectedInfractions},
infractionNotes: ${infractionNotes},
customInfractions: ${customInfractions},
phoneNumber: ${phoneNumber},
password: ${password},
confirmPassword: ${confirmPassword},
hasErrorsInAddEntreprise: ${hasErrorsInAddEntreprise},
hasErrorsInAddCheckup: ${hasErrorsInAddCheckup},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword}
    ''';
  }
}
