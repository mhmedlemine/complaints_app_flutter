import 'dart:async';

import 'package:complaintsapp/data/network/apis/checkup/checkup_api.dart';
import 'package:complaintsapp/data/network/apis/complaint/infraction_api.dart';
import 'package:complaintsapp/data/network/apis/location/moughataa_api.dart';
import 'package:complaintsapp/data/network/apis/shop/entreprise_api.dart';
import 'package:complaintsapp/data/network/apis/shop/merchant_api.dart';
import 'package:complaintsapp/data/network/apis/user_api.dart';
import 'package:complaintsapp/data/repository/checkup/checkup_repository_impl.dart';
import 'package:complaintsapp/data/repository/complaint/infraction_repository_impl.dart';
import 'package:complaintsapp/data/repository/location/moughataa_repository_impl.dart';
import 'package:complaintsapp/data/repository/setting/setting_repository_impl.dart';
import 'package:complaintsapp/data/repository/shop/entreprise_repository_impl.dart';
import 'package:complaintsapp/data/repository/shop/merchant_repository_impl.dart';
import 'package:complaintsapp/data/repository/user/user_repository_impl.dart';
import 'package:complaintsapp/data/sharedpref/shared_preference_helper.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';
import 'package:complaintsapp/domain/repository/complaint/infraction_repository.dart';
import 'package:complaintsapp/domain/repository/location/moughataa_repository.dart';
import 'package:complaintsapp/domain/repository/setting/setting_repository.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';
import 'package:complaintsapp/domain/repository/shop/merchant_repository.dart';
import 'package:complaintsapp/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(), 
      getIt<UserApi>(),
    ));

    getIt.registerSingleton<MoughataaRepository>(MoughataaRepositoryImpl(
      getIt<MoughataaApi>(),
    ));
    getIt.registerSingleton<EntrepriseRepository>(EntrepriseRepositoryImpl(
      getIt<EntrepriseApi>(),
    ));
    getIt.registerSingleton<MerchantRepository>(MerchantRepositoryImpl(
      getIt<MerchantApi>(),
    ));
    getIt.registerSingleton<CheckupRepository>(CheckupRepositoryImpl(
      getIt<CheckupApi>(),
    ));
    getIt.registerSingleton<InfractionRepository>(InfractionRepositoryImpl(
      getIt<InfractionApi>(),
    ));
  }
}
