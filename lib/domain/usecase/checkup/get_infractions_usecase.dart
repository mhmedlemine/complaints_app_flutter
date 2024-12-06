
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/complaint/infraction.dart';
import 'package:complaintsapp/domain/repository/complaint/infraction_repository.dart';

class GetInfractionsUseCase extends UseCase<InfractionList, void> {

  final InfractionRepository _infractionRepository;

  GetInfractionsUseCase(this._infractionRepository);

  @override
  Future<InfractionList> call({required params}) {
    return _infractionRepository.getInfractions();
  }
}