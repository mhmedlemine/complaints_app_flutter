
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class GetMyCheckupsUseCase extends UseCase<CheckupList, void> {

  final CheckupRepository _checkupRepository;

  GetMyCheckupsUseCase(this._checkupRepository);

  @override
  Future<CheckupList> call({required params}) {
    return _checkupRepository.getCheckups();
  }
}