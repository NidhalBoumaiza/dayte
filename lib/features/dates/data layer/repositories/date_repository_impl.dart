import 'package:client/core/error/failures.dart';
import 'package:client/features/authorisation/domain%20layer/entities/user_entity.dart';
import 'package:client/features/dates/domain%20layer/entities/match_entity.dart';
import 'package:client/features/dates/domain%20layer/repositories/date_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../data sources/date_remote_data_source.dart';

class DateRepositoryImpl implements DateRepository {
  final DateRemoteDataSource dateRemoteDataSource;
  final NetworkInfo networkInfo;

  DateRepositoryImpl({
    required this.dateRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<User>>> getRecommendations(bool isShuffle) async {
    if (await networkInfo.isConnected) {
      try {
        final recommendations =
            await dateRemoteDataSource.getRecommendations(isShuffle);
        return Right(recommendations);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on EndOfPlanException {
        return Left(EndOfPlanFailure());
      } on ShuffleException {
        return Left(ShuffleFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<MatchEntity>>> getUserMatches() async {
    if (await networkInfo.isConnected) {
      try {
        final matches = await dateRemoteDataSource.getUserMatches();
        return Right(matches);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on EndOfPlanException {
        return Left(EndOfPlanFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> likeRecommendation(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        await dateRemoteDataSource.likeRecommendation(userId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on MatchedException {
        return Left(MatchedUserFailure());
      } on EndOfPlanException {
        return Left(EndOfPlanFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> proposeTimeAndDate(
      String userId, DateTime dateTime) async {
    if (await networkInfo.isConnected) {
      try {
        await dateRemoteDataSource.proposeTimeAndDate(userId, dateTime);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on EndOfPlanException {
        return Left(EndOfPlanFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> shuffleRecommendations() async {
    if (await networkInfo.isConnected) {
      try {
        await dateRemoteDataSource.shuffleRecommendations();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on EndOfPlanException {
        return Left(EndOfPlanFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> cancelDate(String dateId) async {
    if (await networkInfo.isConnected) {
      try {
        await dateRemoteDataSource.cancelDate(dateId);
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on ServerMessageException {
        return Left(ServerMessageFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on EndOfPlanException {
        return Left(EndOfPlanFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
