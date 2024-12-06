import 'dart:async';

import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/domain/repository/setting/setting_repository.dart';
import 'package:complaintsapp/domain/usecase/checkup/add_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/add_consumer_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/cancel_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_consumer_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_entreprise_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_infractions_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_my_checkups_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_my_complaints_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/get_my_summons_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/save_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/start_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/submit_checkup_usecase.dart';
import 'package:complaintsapp/domain/usecase/checkup/submit_complaint_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/add_entreprise_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/add_merchant_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_entreprise_code_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_merchant_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_moughataas_usecase.dart';
import 'package:complaintsapp/domain/usecase/shop/get_my_entreprises_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/get_logged_in_user_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/login_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/presentation/home/store/language/language_store.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/presentation/login/store/phone_auth_store.dart';
import 'package:complaintsapp/presentation/shop/store/shop_store.dart';

import '../../../di/service_locator.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerFactory(() => PhoneAuthStore());
    getIt.registerSingleton<UserStore>(
      UserStore(
        getIt<GetLoggedInUserUseCase>(),
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ShopStore>(
      ShopStore(
        getIt<ErrorStore>(),
        getIt<GetMyEntreprisesUseCase>(),
        getIt<GetMoughataasUseCase>(),
        getIt<AddEntrepriseUsecase>(),
        getIt<AddMerchantUsecase>(),
        getIt<GetMerchantUseCase>(),
        getIt<GetEntrepriseCodeUseCase>(),
      ),
    );

    getIt.registerSingleton<CheckupStore>(
      CheckupStore(
        getIt<ErrorStore>(),
        getIt<StartCheckupUsecase>(),
        getIt<SaveCheckupUsecase>(),
        getIt<SubmitCheckupUsecase>(),
        getIt<CancelCheckupUsecase>(),
        getIt<SubmitComplaintUsecase>(),
        getIt<GetMyCheckupsUseCase>(),
        getIt<GetMySummonsUseCase>(),
        getIt<GetInfractionsUseCase>(),
        getIt<AddCheckupUsecase>(),
        getIt<GetMyComplaintCheckupsUseCase>(),
        getIt<GetEntrepriseUseCase>(),
        getIt<AddConsumerUsecase>(),
        getIt<GetConsumerUseCase>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
