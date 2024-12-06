import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/domain/repository/shop/merchant_repository.dart';

class AddMerchantUsecase extends UseCase<Merchant, Merchant> {
  final MerchantRepository _merchantRepository;

  AddMerchantUsecase(this._merchantRepository);

  @override
  Future<Merchant> call({required params}) {
    return _merchantRepository.insert(params);
  }
}
