import 'dart:async';

import 'package:complaintsapp/domain/entity/complaint/summon.dart';

abstract class SummonRepository {
  Future<SummonList> getSummons();

  Future<Summon> findSummonById(int id);

  Future<int> insert(Summon summon);

  Future<int> update(Summon summon);

  Future<int> delete(int id);
}
