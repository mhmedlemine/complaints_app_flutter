import 'dart:async';

import 'package:complaintsapp/data/network/apis/complaint/infraction_api.dart';
import 'package:complaintsapp/domain/entity/complaint/infraction.dart';
import 'package:complaintsapp/domain/repository/complaint/infraction_repository.dart';

class InfractionRepositoryImpl extends InfractionRepository {

  // api objects
  final InfractionApi _infractionApi;

  // constructor
  InfractionRepositoryImpl(this._infractionApi);

  // Infraction: ---------------------------------------------------------------------
  @override
  Future<InfractionList> getInfractions() async {
    return await _infractionApi.getMyInfractions().then((infractionsList) {
      return infractionsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Infraction> findInfractionById(int id) {
    return Future.value(Infraction());
  }

  @override
  Future<int> insert(Infraction infraction) async {
    return await _infractionApi.addInfraction(infraction).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Infraction infraction) async {
    return await _infractionApi.updateInfraction(infraction).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _infractionApi.deleteInfraction(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
