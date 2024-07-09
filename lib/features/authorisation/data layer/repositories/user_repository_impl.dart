// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:client/core/error/failures.dart';
import 'package:client/features/authorisation/domain%20layer/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain layer/repositories/user_repository.dart';
import '../data sources/user_local_data_source.dart';
import '../data sources/user_remote_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> register(
      String phoneNumber, String password, String confirmPassword) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.register(
            phoneNumber, password, confirmPassword);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendVerificationCode() async {
    if (await networkInfo.isConnected) {
      try {
        final verificationCode =
            await userRemoteDataSource.sendVerificationCode();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneNumber(String code) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.verifyPhoneNumber(code);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> finishProfile(User user) async {
    final UserModel userModel = UserModel(
      phoneNumber: user.phoneNumber,
      password: user.password,
      name: user.name,
      dateOfBirth: user.dateOfBirth,
      gender: user.gender,
      interests: user.interests,
      prompts: user.prompts,
      description: user.description,
      images: user.images,
      location: user.location,
      plan: user.plan,
      endOfPlan: user.endOfPlan,
    );
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.finishProfile(userModel);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      String phoneNumber, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel =
            await userRemoteDataSource.login(phoneNumber, password);
        await userLocalDataSource.cacheUser(userModel);
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final UserModel userModel = await userRemoteDataSource.getProfile();
        print(userModel.phoneNumber);
        return Right(userModel);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      try {
        await userLocalDataSource.signOut();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateLocation(Location location) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.updateLocation(location);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        await userLocalDataSource.signOut();
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword) async {
    if (await networkInfo.isConnected) {
      try {
        await userRemoteDataSource.changePassword(
            oldPassword, newPassword, confirmNewPassword);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
