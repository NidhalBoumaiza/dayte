import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class SendVerificationCodeUseCase {
  final UserRepository userRepository;

  SendVerificationCodeUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call() async {
    return userRepository.sendVerificationCode();
  }
}
