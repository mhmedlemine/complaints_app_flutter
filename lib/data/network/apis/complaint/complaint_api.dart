import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';

class ComplaintApi {
  final DioClient _dioClient;

  ComplaintApi(this._dioClient);

  Future<int> addComplaint(Complaint compalint) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.addCheckup,
        data: compalint.toMap(),
      );
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateComplaint(Complaint compalint) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: compalint.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteComplaint(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ComplaintList> getMyComplaints() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMyCheckups);
      return ComplaintList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
