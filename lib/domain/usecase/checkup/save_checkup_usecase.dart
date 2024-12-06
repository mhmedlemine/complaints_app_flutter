import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/data/network/apis/checkup/dtos/save_checkup_dto.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class SaveCheckupUsecase extends UseCase<Checkup, SaveCheckupDto> {
  final CheckupRepository _checkupRepository;

  SaveCheckupUsecase(this._checkupRepository);

  @override
  Future<Checkup> call({required params}) {
    return _checkupRepository.save(params);
  }
}
