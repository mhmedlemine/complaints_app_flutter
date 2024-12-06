import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class CancelCheckupUsecase extends UseCase<void, int> {
  final CheckupRepository _checkupRepository;

  CancelCheckupUsecase(this._checkupRepository);

  @override
  Future<void> call({required params}) {
    return _checkupRepository.cancel(params);
  }
}
