
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/location/moughataa.dart';
import 'package:complaintsapp/domain/repository/location/moughataa_repository.dart';

class GetMoughataasUseCase extends UseCase<MoughataaList, void> {

  final MoughataaRepository _moughataaRepository;

  GetMoughataasUseCase(this._moughataaRepository);

  @override
  Future<MoughataaList> call({required params}) {
    return _moughataaRepository.getMoughataas();
  }
}