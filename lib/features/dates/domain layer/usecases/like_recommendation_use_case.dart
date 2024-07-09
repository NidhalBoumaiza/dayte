import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/date_repository.dart';

class LikeRecommendationUseCase {
  final DateRepository dateRepository;

  LikeRecommendationUseCase(this.dateRepository);

  Future<Either<Failure, Unit>> call(String userId) async {
    return await dateRepository.likeRecommendation(userId);
  }
}
