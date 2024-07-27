import 'package:client/features/authorisation/domain%20layer/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, Unit>> register(
      String phoneNumber, String password, String confirmPassword);

  Future<Either<Failure, Unit>> sendVerificationCode();

  Future<Either<Failure, Unit>> verifyPhoneNumber(String code);

  Future<Either<Failure, Unit>> finishProfile(User userEntity);

  Future<Either<Failure, User>> login(String phoneNumber, String password);

  Future<Either<Failure, User>> getProfile();

  Future<Either<Failure, Unit>> updateLocation(Location location);

  Future<Either<Failure, Unit>> signOut();

  Future<Either<Failure, Unit>> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword);

  Future<Either<Failure, Unit>> forgotPassword(String phoneNumber);

  Future<Either<Failure, Unit>> resetPassword(
      String phoneNumber, String password, String confirmPassword);
}
