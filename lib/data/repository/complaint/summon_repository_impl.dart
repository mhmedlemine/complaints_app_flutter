import 'dart:async';

import 'package:complaintsapp/data/network/apis/complaint/summon_api.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/domain/repository/complaint/summon_repository.dart';

class SummonRepositoryImpl extends SummonRepository {

  // api objects
  final SummonApi _summonApi;

  // constructor
  SummonRepositoryImpl(this._summonApi);

  // Summon: ---------------------------------------------------------------------
  @override
  Future<SummonList> getSummons() async {
    return await _summonApi.getMySummons().then((summonsList) {
      return summonsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Summon> findSummonById(int id) {
    return Future.value(Summon());
  }

  @override
  Future<int> insert(Summon summon) async {
    return await _summonApi.addSummon(summon).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Summon summon) async {
    return await _summonApi.updateSummon(summon).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _summonApi.deleteSummon(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
