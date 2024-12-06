import 'dart:async';

import 'package:complaintsapp/data/network/apis/shop/merchant_api.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/domain/repository/shop/merchant_repository.dart';

class MerchantRepositoryImpl extends MerchantRepository {

  // api objects
  final MerchantApi _merchantApi;

  // constructor
  MerchantRepositoryImpl(this._merchantApi);

  // Merchant: ---------------------------------------------------------------------
  @override
  Future<MerchantList> getMerchants() async {
    return await _merchantApi.getMerchants().then((merchantsList) {
      return merchantsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<MerchantList> searchMerchants(String query) async {
    return await _merchantApi.searchMerchants(query).then((merchantsList) {
      return merchantsList;
    }).catchError((error) => throw error);
  }

  @override
  Future<Merchant> findMerchantById(int id) {

    return Future.value(Merchant());
  }

  @override
  Future<Merchant> insert(Merchant merchant) async {
    return await _merchantApi.addMerchant(merchant).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> update(Merchant merchant) async {
    return await _merchantApi.updateMerchant(merchant).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  @override
  Future<int> delete(int id)  async {
    return await _merchantApi.deleteMerchant(id).then((res) {
      return res;
    }).catchError((error) => throw error);
  }
}
