import 'package:client/features/authorisation/domain%20layer/entities/user_entity.dart';
import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class LoginUserCase {
  final UserRepository userRepository;

  LoginUserCase(this.userRepository);

  Future<Either<Failure, User>> call(String email, String password) async {
    return await userRepository.login(email, password);
  }
}
