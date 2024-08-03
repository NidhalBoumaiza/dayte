import 'package:client/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../authorisation/domain layer/repositories/user_repository.dart';

class EditProfileUseCase {
  final UserRepository userRepository;

  EditProfileUseCase(this.userRepository);

  Future<Either<Failure, Unit>> call(
    String name,
    String gender,
    DateTime dateOfBirth,
    List<dynamic> images,
  ) async {
    return userRepository.editProfile(name, gender, dateOfBirth, images);
  }
}
