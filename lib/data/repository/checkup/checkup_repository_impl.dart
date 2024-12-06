import 'dart:async';

import 'package:complaintsapp/data/network/apis/checkup/checkup_api.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/save_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/start_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_checkup_dto.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_complaint_dto.dart';
import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/complaint.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class CheckupRepositoryImpl extends CheckupRepository {

  // api objects
  final CheckupApi _checkupApi;

  // constructor
  CheckupRepositoryImpl(this._checkupApi);

  // Checkup: ---------------------------------------------------------------------
  @override
  Future<CheckupList> getCheckups() async {
    return await _checkupApi.getMyCheckups().then((checkupsList) {
      return checkupsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<SummonList> getSummons() async {
    return await _checkupApi.getMySummons().then((list) {
      return list;
    }).catchError((error) => throw error);
  }

  @override
  Future<Checkup> findCheckupById(int id) {
    return Future.value(Checkup());
  }

  @override
  Future<Checkup?> start(StartCheckupDto data) async {
    return await _checkupApi.startCheckup(data).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<Checkup> save(SaveCheckupDto data) async {
    return await _checkupApi.saveProgress(data).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<Checkup> submit(SubmitCheckupDto data) async {
    return await _checkupApi.submitCheckup(data).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<void> cancel(int checkupId) async {
    return await _checkupApi.cancelCheckup(checkupId).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<Complaint> submitComplaint(SubmitComplaintDto data) async {
    return await _checkupApi.submitComplaint(data).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<Consumer> addConsumer(Consumer query) async {
    return await _checkupApi.addConsumer(query).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<ConsumerList> searchConsumers(String query) async {
    return await _checkupApi.searchConsumers(query).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<dynamic> insert(AddCheckupParams checkup) async {
    return await _checkupApi.addCheckup(checkup).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Checkup checkup) async {
    return await _checkupApi.updateCheckup(checkup).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _checkupApi.deleteCheckup(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
  
  @override
  Future<CheckupList> getMyComplaintCheckups() async {
    return await _checkupApi.getMyCheckups().then((checkupsList) {
      return checkupsList;
    }).catchError((error) => throw error);
  }
}
