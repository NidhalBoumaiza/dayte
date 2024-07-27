import 'package:client/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../repositories/date_repository.dart';

class CancelDateUseCase {
  final DateRepository dateRepository;

  CancelDateUseCase(this.dateRepository);

  Future<Either<Failure, Unit>> call(String dateId) async {
    return dateRepository.cancelDate(dateId);
  }
}
