import 'dart:async';

import 'package:complaintsapp/domain/dto/location_params.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';

abstract class EntrepriseRepository {
  Future<EntrepriseList> getEntreprises();

  Future<Entreprise> findEntrepriseById(int id);
  
  Future<String> getEntrepriseCode(String moughataaCode);
  
  Future<Entreprise?> findEntrepriseByLocation(LocationParams params);

  Future<int> insert(Entreprise entreprise);

  Future<int> update(Entreprise entreprise);

  Future<int> delete(int id);
}
