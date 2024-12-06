
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class GetMySummonsUseCase extends UseCase<SummonList, void> {

  final CheckupRepository _checkupRepository;

  GetMySummonsUseCase(this._checkupRepository);

  @override
  Future<SummonList> call({required params}) {
    return _checkupRepository.getSummons();
  }
}