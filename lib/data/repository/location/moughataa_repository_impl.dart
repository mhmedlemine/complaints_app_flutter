import 'dart:async';

import 'package:complaintsapp/data/network/apis/location/moughataa_api.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';
import 'package:complaintsapp/domain/repository/location/moughataa_repository.dart';

class MoughataaRepositoryImpl extends MoughataaRepository {

  // api objects
  final MoughataaApi _moughataaApi;

  // constructor
  MoughataaRepositoryImpl(this._moughataaApi);

  // Moughataa: ---------------------------------------------------------------------
  @override
  Future<MoughataaList> getMoughataas() async {
    return await _moughataaApi.getMoughataas().then((moughataasList) {
      return moughataasList;
    }).catchError((error) => throw error);
  }
}
