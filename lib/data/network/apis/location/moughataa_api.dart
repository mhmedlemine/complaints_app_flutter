import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';

class MoughataaApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  MoughataaApi(this._dioClient);

  /// Returns list of moughataas in response
  Future<MoughataaList> getMoughataas() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMoughataas);
      return MoughataaList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}
