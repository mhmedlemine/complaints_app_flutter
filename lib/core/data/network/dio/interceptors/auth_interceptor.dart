import 'package:complaintsapp/core/services/navigation_service.dart';
import 'package:complaintsapp/data/sharedpref/shared_preference_helper.dart';
import 'package:complaintsapp/utils/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

class AuthInterceptor extends Interceptor {
  final AsyncValueGetter<String?> accessToken;
  // shared pref object
  final SharedPreferenceHelper sharedPrefsHelper;

  final NavigationService _navigationService = GetIt.instance<NavigationService>();

  AuthInterceptor({
    required this.accessToken,
    required this.sharedPrefsHelper,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String token = await accessToken() ?? '';
    if (token.isNotEmpty) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      _logout();
    }
    super.onError(err, handler);
  }

  void _logout() {
    sharedPrefsHelper.isLoggedIn.then((value) {
      sharedPrefsHelper.saveIsLoggedIn(false);
      sharedPrefsHelper.removeAuthToken();
      sharedPrefsHelper.removeAuthUser();
      if (value) {
        _navigationService.navigateToAndRemoveUntil(Routes.login);
      }
    });
  }
}
