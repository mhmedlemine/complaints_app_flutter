import 'dart:async';

import 'package:complaintsapp/core/data/network/dio/dio_client.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';

class MerchantApi {
  final DioClient _dioClient;

  MerchantApi(this._dioClient);

  Future<Merchant> addMerchant(Merchant merchant) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.addMerchant, data: merchant.toMap());
      return Merchant.fromMap(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> updateMerchant(Merchant merchant) async {
    try {
      final res = await _dioClient.dio.put(Endpoints.getMoughataas, data: merchant.toMap());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> deleteMerchant(int id) async {
    try {
      final res = await _dioClient.dio.delete(Endpoints.getMoughataas);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<MerchantList> getMerchants() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getMerchants);
      return MerchantList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<MerchantList> searchMerchants(String query) async {
    try {
      final res = await _dioClient.dio.get(Endpoints.searchMerchant, data: {"query": query});
      return MerchantList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
