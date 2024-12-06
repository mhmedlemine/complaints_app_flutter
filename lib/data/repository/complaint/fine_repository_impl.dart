import 'dart:async';

import 'package:complaintsapp/data/network/apis/complaint/fine_api.dart';
import 'package:complaintsapp/domain/entity/complaint/fine.dart';
import 'package:complaintsapp/domain/repository/complaint/fine_repository.dart';

class FineRepositoryImpl extends FineRepository {

  // api objects
  final FineApi _fineApi;

  // constructor
  FineRepositoryImpl(this._fineApi);

  // Fine: ---------------------------------------------------------------------
  @override
  Future<FineList> getFines() async {
    return await _fineApi.getMyFines().then((finesList) {
      return finesList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Fine> findFineById(int id) {
    return Future.value(Fine());
  }

  @override
  Future<int> insert(Fine fine) async {
    return await _fineApi.addFine(fine).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Fine fine) async {
    return await _fineApi.updateFine(fine).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _fineApi.deleteFine(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
