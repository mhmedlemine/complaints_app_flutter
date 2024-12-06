
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/dto/location_params.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/domain/repository/shop/entreprise_repository.dart';

class GetEntrepriseUseCase extends UseCase<Entreprise?, LocationParams> {

  final EntrepriseRepository _entrepriseRepository;

  GetEntrepriseUseCase(this._entrepriseRepository);

  @override
  Future<Entreprise?> call({required params}) {
    return _entrepriseRepository.findEntrepriseByLocation(params);
  }
}