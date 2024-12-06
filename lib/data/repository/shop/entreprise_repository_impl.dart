import 'dart:async';

import 'package:complaintsapp/data/network/apis/shop/entreprise_api.dart';
import 'package:complaintsapp/domain/dto/location_params.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';

class EntrepriseRepositoryImpl extends EntrepriseRepository {

  // api objects
  final EntrepriseApi _entrepriseApi;

  // constructor
  EntrepriseRepositoryImpl(this._entrepriseApi);

  // Entreprise: ---------------------------------------------------------------------
  @override
  Future<EntrepriseList> getEntreprises() async {
    return await _entrepriseApi.getMyEntreprises().then((entreprisesList) {
      return entreprisesList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Entreprise> findEntrepriseById(int id) {
    return Future.value(Entreprise());
  }

  @override
  Future<String> getEntrepriseCode(String moughataaCode) async {
    return await _entrepriseApi.getEntrepriseCode(moughataaCode).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<Entreprise?> findEntrepriseByLocation(LocationParams params) async {
    return await _entrepriseApi.findByLocation(params).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> insert(Entreprise entreprise) async {
    return await _entrepriseApi.addEntreprise(entreprise).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Entreprise entreprise) async {
    return await _entrepriseApi.updateEntreprise(entreprise).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _entrepriseApi.deleteEntreprise(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
