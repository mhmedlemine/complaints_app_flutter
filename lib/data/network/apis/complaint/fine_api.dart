import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/complaint/fine.dart';

class FineApi {
  final DioClient _dioClient;

  FineApi(this._dioClient);

  Future<int> addFine(Fine fine) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.addCheckup,
        data: fine.toMap(),
      );
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateFine(Fine fine) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: fine.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteFine(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<FineList> getMyFines() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMyCheckups);
      return FineList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
