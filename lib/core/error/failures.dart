import 'package:client/core/strings.dart';
import 'package:equatable/equatable.dart';

import '../../features/authorisation/domain layer/entities/user_entity.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  static const String message = OfflineFailureMessage;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  static const String message = ServerFailureMessage;

  @override
  List<Object?> get props => [message];
}

class EmptyCacheFailure extends Failure {
  static const String message = EmptyCacheFailureMessage;

  @override
  List<Object?> get props => [message];
}

class ServerMessageFailure extends Failure {
  static late String message;

  ServerMessageFailure();

  @override
  List<Object?> get props => [message];
}

class UnauthorizedFailure extends Failure {
  static late String message;

  UnauthorizedFailure();

  @override
  List<Object?> get props => [message];
}

class MatchedUserFailure extends Failure {
  static late String id;

  static late User likingUser;
  static late User likedUser;

  MatchedUserFailure();

  @override
  List<Object?> get props => [];
}

class EndOfPlanFailure extends Failure {
  static late String message ;
  EndOfPlanFailure();
  @override
  List<Object?> get props => [message];
}
