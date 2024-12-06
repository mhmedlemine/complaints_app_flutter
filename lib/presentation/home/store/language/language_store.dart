import 'package:complaintsapp/constants/assets.dart';
import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/domain/entity/language/Language.dart';
import 'package:complaintsapp/domain/repository/setting/setting_repository.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String TAG = "LanguageStore";

  // repository instance
  final SettingRepository _repository;

  // store for handling errors
  final ErrorStore errorStore;

  List<Language> supportedLanguages = [
    Language(
      flag: Assets.mauritaniaFlag,
      code: 'MR',
      locale: 'ar',
      language: 'العربية',
    ),
    Language(
      flag: Assets.usaFlag,
      code: 'US',
      locale: 'en',
      language: 'English',
    ),
    Language(
      flag: Assets.franceFlag,
      code: 'FR',
      locale: 'fr',
      language: 'Français',
    ),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore(this._repository, this.errorStore) {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _locale = "en";

  @computed
  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    _locale = value;
    _repository.changeLanguage(value).then((_) {
      // write additional logic here
    });
  }

  @action
  String getCode() {
    var code;

    if (_locale == 'en') {
      code = "US";
    } else if (_locale == 'da') {
      code = "DK";
    } else if (_locale == 'es') {
      code = "ES";
    }

    return code;
  }

  @action
  String? getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    if (_repository.currentLanguage != null) {
      _locale = _repository.currentLanguage!;
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
