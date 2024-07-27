import 'package:client/core/error/failures.dart';
import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordUseCase {
  final UserRepository userRepository;

  ForgetPasswordUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(String phoneNumber) async {
    return userRepository.forgotPassword(phoneNumber);
  }
}
