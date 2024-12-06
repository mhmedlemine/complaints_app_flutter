import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  _FormStore(this.formErrorStore, this.errorStore) {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => phoneNumber, validatePhoneNumber),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => code, validatecode),
      reaction((_) => name, validatename),
      reaction((_) => moughataa_id, validatemoughataa_id),
      reaction((_) => owner_id, validateowner_id),
      reaction((_) => lat, validatelat),
      reaction((_) => lon, validatelon),
      reaction((_) => neighbourhood, validateneighbourhood),
      reaction((_) => address, validateaddress),
      reaction((_) => type, validatetype),
      reaction((_) => rg, validaterg),
      reaction((_) => notes, validatenotes),
      reaction((_) => checkupCode, validateCheckupCode),
      reaction((_) => checkupStatus, validateCheckupStatus),
      reaction((_) => actionTaken, validateActionTaken),
      reaction((_) => entreprise_id, validateEntreprise_id),
      reaction((_) => checkupNotes, validateCheckupNotes),
      reaction(
        (_) => selectedInfractions,
        (_) => validateSelectedInfractions(selectedInfractions, checkupStatus),
      ),
      reaction((_) => infractionNotes, validateInfractionNotes),
      reaction((_) => customInfractions, validateCustomInfractions),
    ];
  }

  // store variables:-----------------------------------------------------------
  // COMPLAINT FIELDS
  @observable
  String complaintTitle = '';

  @observable
  String complaintDescription = '';

  @observable
  String greenNumber = '';

  @observable
  int consumerId = 0;

  @observable
  String shopAddress = '';

  @computed
  bool get canSubmitComplaint {
    return complaintTitle.isNotEmpty &&
        complaintDescription.isNotEmpty &&
        greenNumber.isNotEmpty &&
        consumerId != 0 &&
        shopAddress.isNotEmpty &&
        (selectedInfractions.values.contains(true) ||
            customInfractions.isNotEmpty);
  }

  @action
  void setComplaintTitle(String value) {
    complaintTitle = value;
  }

  @action
  void setComplaintDescription(String value) {
    complaintDescription = value;
  }

  @action
  void setGreenNumber(String value) {
    greenNumber = value;
  }

  @action
  void setConsumerId(int value) {
    consumerId = value;
  }

  @action
  void setShopAddress(String value) {
    shopAddress = value;
  }

  @action
  void validateComplaintTitle(String value) {
    if (value.isEmpty) {
      formErrorStore.complaintTitle = AppLocalizations.instance
          .translate('form_complaintTitle_cant_be_empty');
    } else {
      formErrorStore.complaintTitle = null;
    }
  }

  @action
  void validateComplaintDescription(String value) {
    if (value.isEmpty) {
      formErrorStore.complaintDescription = AppLocalizations.instance
          .translate('form_complaintDescription_cant_be_empty');
    } else {
      formErrorStore.complaintDescription = null;
    }
  }

  @action
  void validateGreenNumber(String value) {
    if (value.isEmpty) {
      formErrorStore.greenNumber =
          AppLocalizations.instance.translate('form_greenNumber_cant_be_empty');
    } else {
      formErrorStore.greenNumber = null;
    }
  }

  @action
  void validateConsumerId(int value) {
    if (value == 0) {
      formErrorStore.consumerId =
          AppLocalizations.instance.translate('form_consumerId_cant_be_empty');
    } else {
      formErrorStore.consumerId = null;
    }
  }

  @action
  void validateShopAddress(String value) {
    if (value.isEmpty) {
      formErrorStore.shopAddress =
          AppLocalizations.instance.translate('form_shopAddress_cant_be_empty');
    } else {
      formErrorStore.shopAddress = null;
    }
  }

  void validateComplaintForm() {
    validateComplaintTitle(complaintTitle);
    validateComplaintDescription(complaintDescription);
    validateGreenNumber(greenNumber);
    validateConsumerId(consumerId);
    validateShopAddress(shopAddress);
  }
  // END COMPLAINT FIELDS

  // CONSUMER FIELDS
  @observable
  String consumerFName = '';

  @observable
  String consumerLName = '';

  @observable
  String consumerPhone = '';

  @observable
  String consumerNNI = '';

  @observable
  String consumerAddress = '';

  @action
  void setConsumerFName(String value) {
    consumerFName = value;
  }

  @action
  void setConsumerLName(String value) {
    consumerLName = value;
  }

  @action
  void setConsumerPhone(String value) {
    consumerPhone = value;
  }

  @action
  void setConsumerNNI(String value) {
    consumerNNI = value;
  }

  @action
  void setConsumerAddress(String value) {
    consumerAddress = value;
  }

  @action
  void validateConsumerFName(String value) {
    if (value.isEmpty) {
      formErrorStore.consumerFName = AppLocalizations.instance
          .translate('form_consumerFName_cant_be_empty');
    } else {
      formErrorStore.consumerFName = null;
    }
  }

  @action
  void validateConsumerLName(String value) {
    if (value.isEmpty) {
      formErrorStore.consumerLName = AppLocalizations.instance
          .translate('form_consumerLName_cant_be_empty');
    } else {
      formErrorStore.consumerLName = null;
    }
  }

  @action
  void validateConsumerPhone(String value) {
    if (value.isEmpty) {
      formErrorStore.consumerPhone = AppLocalizations.instance
          .translate('form_consumerPhone_cant_be_empty');
    } else {
      formErrorStore.consumerPhone = null;
    }
  }

  @action
  void validateConsumerNNI(String value) {
    if (value.isEmpty) {
      formErrorStore.consumerNNI =
          AppLocalizations.instance.translate('form_consumerNNI_cant_be_empty');
    } else {
      formErrorStore.consumerNNI = null;
    }
  }

  validateConsumer() {
    validateConsumerFName(consumerFName);
    validateConsumerLName(consumerLName);
    validateConsumerPhone(consumerPhone);
    validateConsumerNNI(consumerNNI);
  }

  @action
  void validateConsumerAddress(String value) {
    if (value.isEmpty) {
      // formErrorStore.consumerAddress = AppLocalizations.instance
      //     .translate('form_consumerAddress_cant_be_empty');
    } else {
      formErrorStore.consumerAddress = null;
    }
  }

  @computed
  bool get canSaveConsumer {
    return consumerFName.isNotEmpty &&
        consumerPhone.isNotEmpty;
  }
  // END CONSUMER FIELDS

  // Entreprise fields
  @observable
  String code = '';

  @observable
  String name = '';

  @observable
  int moughataa_id = 0;

  @observable
  int owner_id = 0;

  @observable
  double lat = 0;

  @observable
  double lon = 0;

  @observable
  String neighbourhood = '';

  @observable
  String address = '';

  @observable
  String type = '';

  @observable
  String rg = '';

  @observable
  String notes = '';
  //-- END Entreprise fields

  // Checkup fields
  @observable
  String checkupCode = '';

  @observable
  String checkupStatus = 'clean';

  @observable
  String actionTaken = 'summon_issued';

  @observable
  int entreprise_id = 0;

  @observable
  String checkupNotes = '';

  @observable
  Map<int, bool> selectedInfractions = {};

  @observable
  Map<int, String> infractionNotes = {};

  @observable
  Map<int, int?> checkupInfractionIds = {};

  @observable
  List<Map<String, dynamic>> customInfractions = [];
  //-- END Checkup fields

  @observable
  String fname = '';

  @observable
  String lname = '';

  @observable
  String phoneNumber = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool success = false;

  @computed
  bool get canSaveEntreprise => !formErrorStore.hasErrorsInAddEntreprise;

  @computed
  bool get canSaveCheckup => !formErrorStore.hasErrorsInAddCheckup;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      phoneNumber.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      phoneNumber.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && phoneNumber.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setCode(String value) {
    code = value;
  }

  @action
  void setName(String value) {
    name = value;
  }

  @action
  void setMoughataaId(int value) {
    moughataa_id = value;
  }

  @action
  void setOwnerId(int value) {
    owner_id = value;
  }

  @action
  void setLat(double value) {
    lat = value;
  }

  @action
  void setLon(double value) {
    lon = value;
  }

  @action
  void setNeighbourhood(String value) {
    neighbourhood = value;
  }

  @action
  void setAddress(String value) {
    address = value;
  }

  @action
  void setType(String value) {
    type = value;
  }

  @action
  void setRg(String value) {
    rg = value;
  }

  @action
  void setNotes(String value) {
    notes = value;
  }

  @action
  void setCheckupCode(String value) {
    checkupCode = value;
  }

  @action
  void setCheckupStatus(String value) {
    if (checkupStatus == 'clean') {
      selectedInfractions.clear();
      infractionNotes.clear();
      customInfractions.clear();
    }
    checkupStatus = value;
  }

  @action
  void setActionTaken(String value) {
    actionTaken = value;
  }

  @action
  void setEntreprise_id(int value) {
    entreprise_id = value;
  }

  @action
  void setCheckupNotes(String value) {
    checkupNotes = value;
  }

  @action
  void setSelectedInfractions(Map<int, bool> value) {
    selectedInfractions = value;
  }

  @action
  void setInfractionNotes(Map<int, String> value) {
    infractionNotes = value;
  }

  @action
  void setCustomInfractions(List<Map<String, String>> value) {
    customInfractions = value;
  }

  @action
  void setUserId(String value) {
    phoneNumber = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validatePhoneNumber(String value) {
    const phoneRegex = r"""^[234]{1}[0-9]{7}$""";
    if (value.trim().isEmpty) {
      formErrorStore.phoneNumber =
          AppLocalizations.instance.translate('form_enter_phone_number');
    } else if (!RegExp(phoneRegex).hasMatch(value)) {
      formErrorStore.phoneNumber =
          AppLocalizations.instance.translate('form_invalid_phone_number');
    } else {
      formErrorStore.phoneNumber = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password =
          AppLocalizations.instance.translate('form_enter_password');
    }
    //  else if (value.length < 6) {
    //   formErrorStore.password = "Password must be at-least 6 characters long";
    // } else
    {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = AppLocalizations.instance
          .translate('form_enter_password_confirmation');
    } else if (value != password) {
      formErrorStore.confirmPassword =
          AppLocalizations.instance.translate('form_password_does_not_match');
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  void validatecode(String value) {
    if (value.isEmpty) {
      formErrorStore.code =
          AppLocalizations.instance.translate('form_code_cant_be_empty');
    } else {
      formErrorStore.code = null;
    }
  }

  @action
  void validatename(String value) {
    if (value.isEmpty) {
      formErrorStore.name =
          AppLocalizations.instance.translate('form_name_cant_be_empty');
    } else {
      formErrorStore.name = null;
    }
  }

  @action
  void validatemoughataa_id(int value) {
    if (value == 0 || value.toString().isEmpty) {
      formErrorStore.moughataa_id = "moughataa_id Can't be empty";
    } else {
      formErrorStore.moughataa_id = null;
    }
  }

  @action
  void validateowner_id(int value) {
    if (value == 0 || value.toString().isEmpty) {
      formErrorStore.owner_id = "owner_id Can't be empty";
    } else {
      formErrorStore.owner_id = null;
    }
  }

  @action
  void validatelat(double value) {
    if (value == 0 || value.toString().isEmpty) {
      formErrorStore.lat = "lat Can't be empty";
    } else {
      formErrorStore.lat = null;
    }
  }

  @action
  void validatelon(double value) {
    if (value == 0 || value.toString().isEmpty) {
      formErrorStore.lon = "lon Can't be empty";
    } else {
      formErrorStore.lon = null;
    }
  }

  @action
  void validateneighbourhood(String value) {
    if (value.isEmpty) {
      formErrorStore.neighbourhood = AppLocalizations.instance
          .translate('form_neighbourhood_cant_be_empty');
    } else {
      formErrorStore.neighbourhood = null;
    }
  }

  @action
  void validateaddress(String value) {
    if (value.isEmpty) {
      //formErrorStore.address AppLocalizations.instance.translate('form_address_cant_be_empty');
    } else {
      formErrorStore.address = null;
    }
  }

  @action
  void validatetype(String value) {
    if (value.isEmpty) {
      formErrorStore.type =
          AppLocalizations.instance.translate('form_type_cant_be_empty');
    } else {
      formErrorStore.type = null;
    }
  }

  @action
  void validaterg(String value) {
    if (value.isEmpty) {
      //formErrorStore.rg AppLocalizations.instance.translate('form_rg_cant_be_empty');
    } else {
      formErrorStore.rg = null;
    }
  }

  @action
  void validatenotes(String value) {
    if (value.isEmpty) {
      //formErrorStore.notes AppLocalizations.instance.translate('form_notes_cant_be_empty');
    } else {
      formErrorStore.notes = null;
    }
  }

  @action
  void validateCheckupCode(String value) {
    if (value.isEmpty) {
      formErrorStore.checkupCode =
          AppLocalizations.instance.translate('form_checkupCode_cant_be_empty');
    } else {
      formErrorStore.checkupCode = null;
    }
  }

  @action
  void validateCheckupStatus(String value) {
    if (value.isEmpty) {
      formErrorStore.checkupStatus = AppLocalizations.instance
          .translate('form_checkupStatus_cant_be_empty');
    } else {
      formErrorStore.checkupStatus = null;
    }
  }

  @action
  void validateActionTaken(String value) {
    if (value.isEmpty) {
      formErrorStore.actionTaken =
          AppLocalizations.instance.translate('form_actionTaken_cant_be_empty');
    } else {
      formErrorStore.actionTaken = null;
    }
  }

  @action
  void validateEntreprise_id(int value) {
    if (value == 0) {
      formErrorStore.entreprise_id = AppLocalizations.instance
          .translate('form_entreprise_id_cant_be_empty');
    } else {
      formErrorStore.entreprise_id = null;
    }
  }

  @action
  void validateCheckupNotes(String value) {
    if (value.isEmpty) {
      // formErrorStore.checkupNotes = AppLocalizations.instance.translate('form_checkupNotes_cant_be_empty');
    } else {
      formErrorStore.checkupNotes = null;
    }
  }

  @action
  void validateSelectedInfractions(Map<int, bool> value, String statusValue) {
    if (statusValue == 'with_infractions' &&
        customInfractions.isEmpty &&
        value.isEmpty) {
      formErrorStore.selectedInfractions = AppLocalizations.instance
          .translate('form_selectedInfractions_cant_be_empty');
    } else {
      formErrorStore.selectedInfractions = null;
    }
  }

  @action
  void validateInfractionNotes(Map<int, String> value) {
    if (value.isEmpty) {
      // formErrorStore.infractionNotes = AppLocalizations.instance.translate('form_infractionNotes_cant_be_empty');
    } else {
      formErrorStore.infractionNotes = null;
    }
  }

  @action
  void validateCustomInfractions(List<Map<String, dynamic>> value) {
    if (value.isNotEmpty && value.any((i) => i['text']?.isEmpty == true)) {
      formErrorStore.customInfractions = AppLocalizations.instance
          .translate('form_customInfractions_cant_be_empty');
    } else {
      formErrorStore.customInfractions = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validatePhoneNumber(phoneNumber);

    validatecode(code);
    validatename(name);
    validatemoughataa_id(moughataa_id);
    validateowner_id(owner_id);
    validatelat(lat);
    validatelon(lon);
    validateneighbourhood(neighbourhood);
    validateaddress(address);
    validatetype(type);
    validaterg(rg);
    validatenotes(notes);
  }

  void validateCheckup() {
    validateCheckupCode(checkupCode);
    validateCheckupStatus(checkupStatus);
    validateActionTaken(actionTaken);
    validateEntreprise_id(entreprise_id);
    validateCheckupNotes(checkupNotes);
    validateSelectedInfractions(selectedInfractions, checkupStatus);
    validateInfractionNotes(infractionNotes);
    validateCustomInfractions(customInfractions);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  // COMPLAINT FIELDS
  @observable
  String? complaintTitle;

  @observable
  String? complaintDescription;

  @observable
  String? greenNumber;

  @observable
  String? consumerId;

  @observable
  String? shopAddress;

  // COMPLAINT FIELDS

  // CONSUMER FIELDS
  @observable
  String? consumerFName;

  @observable
  String? consumerLName;

  @observable
  String? consumerPhone;

  @observable
  String? consumerNNI;

  @observable
  String? consumerAddress;
  // CONSUMER FIELDS

  // Entreprise fields
  @observable
  String? code;

  @observable
  String? name;

  @observable
  String? moughataa_id;

  @observable
  String? owner_id;

  @observable
  String? lat;

  @observable
  String? lon;

  @observable
  String? neighbourhood;

  @observable
  String? address;

  @observable
  String? type;

  @observable
  String? rg;

  @observable
  String? notes;
  //-- END Entreprise fields

  // Checkup fields
  @observable
  String? checkupCode;

  @observable
  String? checkupStatus;

  @observable
  String? actionTaken;

  @observable
  String? entreprise_id;

  @observable
  String? checkupNotes;

  @observable
  String? selectedInfractions;

  @observable
  String? infractionNotes;

  @observable
  String? customInfractions;
  //-- END Checkup fields

  @observable
  String? phoneNumber;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @computed
  bool get hasErrorsInAddEntreprise =>
      code != null ||
      name != null ||
      moughataa_id != null ||
      owner_id != null ||
      lat != null ||
      lon != null ||
      neighbourhood != null ||
      type != null;

  @computed
  bool get hasErrorsInAddCheckup =>
      checkupCode != null ||
      checkupStatus != null ||
      actionTaken != null ||
      entreprise_id != null ||
      checkupNotes != null ||
      selectedInfractions != null ||
      infractionNotes != null ||
      customInfractions != null;

  @computed
  bool get hasErrorsInLogin => phoneNumber != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      phoneNumber != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => phoneNumber != null;
}
