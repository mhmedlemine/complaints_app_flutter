import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/start_checkup_dto.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class StartCheckupUsecase extends UseCase<Checkup?, StartCheckupDto> {
  final CheckupRepository _checkupRepository;

  StartCheckupUsecase(this._checkupRepository);

  @override
  Future<Checkup?> call({required params}) {
    return _checkupRepository.start(params);
  }
}
