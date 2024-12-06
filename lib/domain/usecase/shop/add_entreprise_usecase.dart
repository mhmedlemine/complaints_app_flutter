import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';

class AddEntrepriseUsecase extends UseCase<int, Entreprise> {
  final EntrepriseRepository _entrepriseRepository;

  AddEntrepriseUsecase(this._entrepriseRepository);

  @override
  Future<int> call({required params}) {
    return _entrepriseRepository.insert(params);
  }
}
