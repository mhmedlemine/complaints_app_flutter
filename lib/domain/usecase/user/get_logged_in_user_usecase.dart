import 'package:complaintsapp/domain/entity/user/user.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user/user_repository.dart';

class GetLoggedInUserUseCase implements UseCase<User?, void> {
  final UserRepository _userRepository;

  GetLoggedInUserUseCase(this._userRepository);

  @override
  Future<User?> call({required void params}) async {
    return await _userRepository.loggedInUser;
  }
}
