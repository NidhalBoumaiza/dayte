import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class FinishProfileUseCase {
  final UserRepository userRepository;

  FinishProfileUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(User userEntity) async {
    return userRepository.finishProfile(userEntity);
  }
}
