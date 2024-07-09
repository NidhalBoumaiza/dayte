import 'package:client/features/dates/domain%20layer/repositories/date_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../authorisation/domain layer/entities/user_entity.dart';

class GetRecommendationUseCase {
  final DateRepository dateRepository;

  GetRecommendationUseCase(this.dateRepository);

  Future<Either<Failure, List<User>>> call() async {
    return await dateRepository.getRecommendations();
  }
}
