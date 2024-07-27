import 'package:client/features/dates/domain%20layer/entities/match_entity.dart';
import 'package:client/features/dates/domain%20layer/repositories/date_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetUserMatches {
  final DateRepository dateRepository;

  GetUserMatches(this.dateRepository);

  Future<Either<Failure, List<MatchEntity>>> call() async {
    return await dateRepository.getUserMatches();
  }
}
