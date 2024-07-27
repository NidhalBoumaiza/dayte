import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class ResetPasswordUseCase {
  final UserRepository userRepository;

  ResetPasswordUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(
      String phoneNumber, String password, String confirmPassword) async {
    return userRepository.resetPassword(phoneNumber, password, confirmPassword);
  }
}
