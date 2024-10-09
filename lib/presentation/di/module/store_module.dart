import 'dart:async';

import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/domain/repository/setting/setting_repository.dart';
import 'package:complaintsapp/domain/usecase/post/get_post_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/login_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:complaintsapp/presentation/home/store/language/language_store.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/presentation/login/store/phone_auth_store.dart';
import 'package:complaintsapp/presentation/post/store/post_store.dart';

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
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<PostStore>(
      PostStore(
        getIt<GetPostUseCase>(),
        getIt<ErrorStore>(),
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
