import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/submit_checkup_dto.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class SubmitCheckupUsecase extends UseCase<Checkup, SubmitCheckupDto> {
  final CheckupRepository _checkupRepository;

  SubmitCheckupUsecase(this._checkupRepository);

  @override
  Future<Checkup> call({required params}) {
    return _checkupRepository.submit(params);
  }
}
