import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class VerifyPhoneNumberUseCase {
  final UserRepository userRepository;

  VerifyPhoneNumberUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(String code) async {
    return userRepository.verifyPhoneNumber(code);
  }
}
