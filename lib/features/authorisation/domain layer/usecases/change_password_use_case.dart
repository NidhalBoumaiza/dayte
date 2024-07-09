import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/user_repository.dart';

class ChangePasswordUseCase {
  final UserRepository userRepository;

  ChangePasswordUseCase(this.userRepository);

  Future<Either<Failure, Unit>> execute(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    return userRepository.changePassword(
        oldPassword, newPassword, confirmNewPassword);
  }
}
