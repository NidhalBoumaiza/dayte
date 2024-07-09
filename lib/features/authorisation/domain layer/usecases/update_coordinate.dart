import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class UpdateCoordinateUseCase {
  final UserRepository userRepository;

  UpdateCoordinateUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(Location location) async {
    return await userRepository.updateLocation(location);
  }
}
