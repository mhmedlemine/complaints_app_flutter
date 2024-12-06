import 'dart:async';

import 'package:complaintsapp/data/network/apis/complaint/consumer_api.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/repository/complaint/consumer_repository.dart';

class ConsumerRepositoryImpl extends ConsumerRepository {

  // api objects
  final ConsumerApi _complaintApi;

  // constructor
  ConsumerRepositoryImpl(this._complaintApi);

  // Consumer: ---------------------------------------------------------------------
  @override
  Future<ConsumerList> getConsumers() async {
    return await _complaintApi.getMyConsumers().then((complaintsList) {
      return complaintsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Consumer> findConsumerById(int id) {
    return Future.value(Consumer());
  }

  @override
  Future<int> insert(Consumer complaint) async {
    return await _complaintApi.addConsumer(complaint).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Consumer complaint) async {
    return await _complaintApi.updateConsumer(complaint).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _complaintApi.deleteConsumer(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
