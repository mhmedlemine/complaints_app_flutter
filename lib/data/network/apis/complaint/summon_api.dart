import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';

class SummonApi {
  final DioClient _dioClient;

  SummonApi(this._dioClient);

  Future<int> addSummon(Summon summon) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.addCheckup,
        data: summon.toMap(),
      );
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateSummon(Summon summon) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: summon.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteSummon(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<SummonList> getMySummons() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMyCheckups);
      return SummonList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
