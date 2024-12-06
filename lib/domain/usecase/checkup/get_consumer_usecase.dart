
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class GetConsumerUseCase extends UseCase<ConsumerList, String> {

  final CheckupRepository _merchantRepository;

  GetConsumerUseCase(this._merchantRepository);

  @override
  Future<ConsumerList> call({required params}) {
    return _merchantRepository.searchConsumers(params);
  }
}