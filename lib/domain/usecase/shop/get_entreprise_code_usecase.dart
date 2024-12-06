
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';

class GetEntrepriseCodeUseCase extends UseCase<String, String> {

  final EntrepriseRepository _entrepriseRepository;

  GetEntrepriseCodeUseCase(this._entrepriseRepository);

  @override
  Future<String> call({required params}) {
    return _entrepriseRepository.getEntrepriseCode(params);
  }
}