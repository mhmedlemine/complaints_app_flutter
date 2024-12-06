import 'package:complaintsapp/core/data/network/dio/configs/dio_configs.dart';
import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:complaintsapp/core/data/network/dio/interceptors/logging_interceptor.dart';
import 'package:complaintsapp/data/network/apis/checkup/checkup_api.dart';
import 'package:complaintsapp/data/network/apis/complaint/infraction_api.dart';
import 'package:complaintsapp/data/network/apis/location/moughataa_api.dart';
import 'package:complaintsapp/data/network/apis/shop/entreprise_api.dart';
import 'package:complaintsapp/data/network/apis/shop/merchant_api.dart';
import 'package:complaintsapp/data/network/apis/user_api.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/data/network/interceptors/error_interceptor.dart';
import 'package:complaintsapp/data/network/rest_client.dart';
import 'package:complaintsapp/data/sharedpref/shared_preference_helper.dart';
import 'package:event_bus/event_bus.dart';

import '../../../di/service_locator.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async => await getIt<SharedPreferenceHelper>().authToken,
        sharedPrefsHelper: getIt<SharedPreferenceHelper>(),
      ),
    );

    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: Endpoints.baseUrl,
        connectionTimeout: Endpoints.connectionTimeout,
        receiveTimeout:Endpoints.receiveTimeout,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt())
        ..addInterceptors(
          [
            getIt<AuthInterceptor>(),
            getIt<ErrorInterceptor>(),
            getIt<LoggingInterceptor>(),
          ],
        ),
    );

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton(UserApi(getIt<DioClient>()));
    getIt.registerSingleton(MoughataaApi(getIt<DioClient>()));
    getIt.registerSingleton(EntrepriseApi(getIt<DioClient>()));
    getIt.registerSingleton(MerchantApi(getIt<DioClient>()));
    getIt.registerSingleton(CheckupApi(getIt<DioClient>()));
    getIt.registerSingleton(InfractionApi(getIt<DioClient>()));
  }
}
