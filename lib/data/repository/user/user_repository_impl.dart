import 'dart:async';

import 'package:complaintsapp/data/network/apis/user_api.dart';
import 'package:complaintsapp/domain/repository/user/user_repository.dart';
import 'package:complaintsapp/data/sharedpref/shared_preference_helper.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // api objects
  final UserApi _userApi;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper, this._userApi);

  // Login:---------------------------------------------------------------------
  @override
  Future<User?> login(LoginParams params) async {
    return await _userApi.login(params).then((user) {
      _sharedPrefsHelper.saveAuthToken(user.token!);
      _sharedPrefsHelper.saveUser(user);
      return user;
    }).catchError((error) => throw error);
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
  
  @override
  Future<User?> get loggedInUser => _sharedPrefsHelper.loggedInUser;
}
