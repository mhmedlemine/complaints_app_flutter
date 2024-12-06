import 'dart:async';

import 'package:complaintsapp/domain/entity/shop/merchant.dart';

abstract class MerchantRepository {
  Future<MerchantList> getMerchants();
  
  Future<MerchantList> searchMerchants(String query);

  Future<Merchant> findMerchantById(int id);

  Future<Merchant> insert(Merchant merchant);

  Future<int> update(Merchant merchant);

  Future<int> delete(int id);
}
