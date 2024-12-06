import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/dto/add_checkup_params.dart';
import 'package:complaintsapp/domain/entity/checkup/checkup.dart';
import 'package:complaintsapp/domain/entity/complaint/summon.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class AddCheckupUsecase extends UseCase<dynamic, AddCheckupParams> {
  final CheckupRepository _checkupRepository;

  AddCheckupUsecase(this._checkupRepository);

  @override
  Future<dynamic> call({required params}) {
    return _checkupRepository.insert(params);
  }
}
