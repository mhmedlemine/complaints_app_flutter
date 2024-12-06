import 'package:complaintsapp/core/services/notification_service.dart';
import 'package:complaintsapp/core/stores/error/error_store.dart';
import 'package:complaintsapp/core/stores/form/form_store.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/domain/usecase/user/get_logged_in_user_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:complaintsapp/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

part 'login_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // constructor:---------------------------------------------------------------
  _UserStore(
    this._getLoggedInUserUseCase,
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this.formErrorStore,
    this.errorStore,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
      if (value) {
        getUser();
      }
    });
  }

  @action
  Future getUser() async {
    try {
      this.user = await _getLoggedInUserUseCase.call(params: null);
      print('');
    } catch (e) {
      print(e.toString());
    }
  }

  // use cases:-----------------------------------------------------------------
  final GetLoggedInUserUseCase _getLoggedInUserUseCase;
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;

  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<User?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  bool isLoggedIn = false;

  @observable
  bool success = false;

  @observable
  ObservableFuture<User?> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @observable
  User? user;
  // actions:-------------------------------------------------------------------
  @action
  Future login(String phoneNumber, String password) async {
    final LoginParams loginParams =
        LoginParams(phonenumber: phoneNumber, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        await _saveLoginStatusUseCase.call(params: true);
        this.isLoggedIn = true;
        this.success = true;
        fetchToken();
      }
    }).catchError((e) {
      print(e);
      if (e.type == DioExceptionType.sendTimeout || e.type == DioExceptionType.connectionError || e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.unknown) {
        this.errorStore.errorMessage = "Verifier votre connexion";
      } else {
        this.errorStore.errorMessage = e.response.data["message"];
      }
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  logout() async {
    this.isLoggedIn = false;
    await _saveLoginStatusUseCase.call(params: false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  Future<void> fetchToken() async {
    final notificationService = getIt<NotificationService>();
    String? token = await notificationService.getDeviceToken();
    debugPrint('FCM Device Token: $token');
    // Send this token to your server to send notifications
  }
}
