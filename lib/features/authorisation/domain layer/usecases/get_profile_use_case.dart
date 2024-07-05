import 'package:client/features/authorisation/domain%20layer/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

class GetProfileUseCase {
  final UserRepository userRepository;

  GetProfileUseCase(this.userRepository);

  Future<Either<Failure, User>> call() {
    return userRepository.getProfile();
  }
}
