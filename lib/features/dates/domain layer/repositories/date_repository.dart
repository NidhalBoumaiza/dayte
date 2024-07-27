import 'package:client/features/dates/domain%20layer/entities/match_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authorisation/domain layer/entities/user_entity.dart';

abstract class DateRepository {
  Future<Either<Failure, List<User>>> getRecommendations();

  Future<Either<Failure, List<MatchEntity>>> getUserMatches();

  Future<Either<Failure, Unit>> likeRecommendation(String userId);

  Future<Either<Failure, Unit>> proposeTimeAndDate(
      String userId, DateTime dateTime);

  Future<Either<Failure, Unit>> shuffleRecommendations();

  Future<Either<Failure, Unit>> cancelDate(String dateId);
}
