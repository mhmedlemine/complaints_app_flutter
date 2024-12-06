import 'dart:async';

import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';
import 'package:complaintsapp/domain/repository/complaint/infraction_repository.dart';
import 'package:complaintsapp/domain/repository/location/moughataa_repository.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';
import 'package:complaintsapp/domain/repository/shop/merchant_repository.dart';
import 'package:complaintsapp/domain/repository/user/user_repository.dart';
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

import '../../../di/service_locator.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    getIt.registerSingleton<GetLoggedInUserUseCase>(
      GetLoggedInUserUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );

    // checkup:--------------------------------------------------------------------
    getIt.registerSingleton<StartCheckupUsecase>(
      StartCheckupUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<SaveCheckupUsecase>(
      SaveCheckupUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<SubmitCheckupUsecase>(
      SubmitCheckupUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<CancelCheckupUsecase>(
      CancelCheckupUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<SubmitComplaintUsecase>(
      SubmitComplaintUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<GetMyCheckupsUseCase>(
      GetMyCheckupsUseCase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<GetMySummonsUseCase>(
      GetMySummonsUseCase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<AddCheckupUsecase>(
      AddCheckupUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<AddConsumerUsecase>(
      AddConsumerUsecase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<GetConsumerUseCase>(
      GetConsumerUseCase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<GetEntrepriseUseCase>(
      GetEntrepriseUseCase(getIt<EntrepriseRepository>()),
    );
    getIt.registerSingleton<GetMyComplaintCheckupsUseCase>(
      GetMyComplaintCheckupsUseCase(getIt<CheckupRepository>()),
    );
    getIt.registerSingleton<GetInfractionsUseCase>(
      GetInfractionsUseCase(getIt<InfractionRepository>()),
    );

    // shop:--------------------------------------------------------------------
    getIt.registerSingleton<GetEntrepriseCodeUseCase>(
      GetEntrepriseCodeUseCase(getIt<EntrepriseRepository>()),
    );
    getIt.registerSingleton<GetMyEntreprisesUseCase>(
      GetMyEntreprisesUseCase(getIt<EntrepriseRepository>()),
    );
    getIt.registerSingleton<AddEntrepriseUsecase>(
      AddEntrepriseUsecase(getIt<EntrepriseRepository>()),
    );
    getIt.registerSingleton<GetMoughataasUseCase>(
      GetMoughataasUseCase(getIt<MoughataaRepository>()),
    );
    getIt.registerSingleton<GetMerchantUseCase>(
      GetMerchantUseCase(getIt<MerchantRepository>()),
    );
    getIt.registerSingleton<AddMerchantUsecase>(
      AddMerchantUsecase(getIt<MerchantRepository>()),
    );

  }
}
