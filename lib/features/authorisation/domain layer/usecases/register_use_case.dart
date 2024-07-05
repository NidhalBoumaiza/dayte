import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class RegisterUseCase {
  final UserRepository userRepository;

  RegisterUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(
      String phoneNumber, String password, String confirmPassword) {
    return userRepository.register(phoneNumber, password, confirmPassword);
  }
}
