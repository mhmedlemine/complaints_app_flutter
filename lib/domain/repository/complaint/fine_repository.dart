import 'dart:async';

import 'package:complaintsapp/domain/entity/complaint/fine.dart';


abstract class FineRepository {
  Future<FineList> getFines();

  Future<Fine> findFineById(int id);

  Future<int> insert(Fine fine);

  Future<int> update(Fine fine);

  Future<int> delete(int id);
}
