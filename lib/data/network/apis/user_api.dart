import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/post/post_list.dart';
import 'package:complaintsapp/domain/entity/user/user.dart';
import 'package:complaintsapp/domain/usecase/user/login_usecase.dart';

class UserApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  UserApi(this._dioClient);

  /// Returns list of post in response
  Future<User> login(LoginParams params) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.login,
        data: params.toJson()
      );
      return User.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//   Future<PostList> getPosts() async {
//     try {
//       final res = await _restClient.get(Endpoints.getPosts);
//       return PostList.fromJson(res.data);
//     } catch (e) {
//       print(e.toString());
//       throw e;
//     }
//   }
}
