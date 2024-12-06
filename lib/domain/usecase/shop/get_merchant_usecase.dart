
import 'package:complaintsapp/core/domain/usecase/use_case.dart';
import 'package:complaintsapp/domain/entity/shop/merchant.dart';
import 'package:complaintsapp/domain/repository/shop/merchant_repository.dart';

class GetMerchantUseCase extends UseCase<MerchantList, String> {

  final MerchantRepository _merchantRepository;

  GetMerchantUseCase(this._merchantRepository);

  @override
  Future<MerchantList> call({required params}) {
    return _merchantRepository.searchMerchants(params);
  }
}