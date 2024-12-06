import 'dart:async';

import 'package:complaintsapp/domain/entity/complaint/infraction.dart';

abstract class InfractionRepository {
  Future<InfractionList> getInfractions();

  Future<Infraction> findInfractionById(int id);

  Future<int> insert(Infraction infraction);

  Future<int> update(Infraction infraction);

  Future<int> delete(int id);
}
