import 'package:complaintsapp/data/di/module/local_module.dart';
import 'package:complaintsapp/data/di/module/network_module.dart';
import 'package:complaintsapp/data/di/module/repository_module.dart';

class DataLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await LocalModule.configureLocalModuleInjection();
    await NetworkModule.configureNetworkModuleInjection();
    await RepositoryModule.configureRepositoryModuleInjection();
  }
}
