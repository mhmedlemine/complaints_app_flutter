import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';

class ConsumerApi {
  final DioClient _dioClient;

  ConsumerApi(this._dioClient);

  Future<int> addConsumer(Consumer consumer) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.addCheckup,
        data: consumer.toMap(),
      );
      return res.data["data"];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateConsumer(Consumer consumer) async {
    try {
      final res = await _dioClient.dio
          .put(Endpoints.getMoughataas, data: consumer.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteConsumer(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ConsumerList> getMyConsumers() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMyCheckups);
      return ConsumerList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
