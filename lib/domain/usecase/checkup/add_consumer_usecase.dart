import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/complaint/consumer.dart';
import 'package:complaintsapp/domain/repository/checkup/checkup_repository.dart';

class AddConsumerUsecase extends UseCase<Consumer, Consumer> {
  final CheckupRepository _merchantRepository;

  AddConsumerUsecase(this._merchantRepository);

  @override
  Future<Consumer> call({required params}) {
    return _merchantRepository.addConsumer(params);
  }
}
