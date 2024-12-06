
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';

class GetMyEntreprisesUseCase extends UseCase<EntrepriseList, void> {

  final EntrepriseRepository _entrepriseRepository;

  GetMyEntreprisesUseCase(this._entrepriseRepository);

  @override
  Future<EntrepriseList> call({required params}) {
    return _entrepriseRepository.getEntreprises();
  }
}