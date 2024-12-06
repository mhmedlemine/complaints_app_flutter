import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/complaint/infraction.dart';

class InfractionApi {
  final DioClient _dioClient;

  InfractionApi(this._dioClient);

  Future<int> addInfraction(Infraction infraction) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.addCheckup,
        data: infraction.toMap(),
      );
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateInfraction(Infraction infraction) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: infraction.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteInfraction(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<InfractionList> getMyInfractions() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getInfractions);
      return InfractionList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
