// ignore_for_file: override_on_non_overriding_member

import 'package:equatable/equatable.dart';

class ServerException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

class ServerMessageException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class UnauthorizedException implements Exception {
  const UnauthorizedException();

  @override
  List<Object?> get props => [];
}

class MatchedException implements Exception {
  const MatchedException();

  @override
  List<Object?> get props => [];
}

class EndOfPlanException implements Exception {
  const EndOfPlanException();

  @override
  List<Object?> get props => [];
}

class ShuffleException implements Exception {
  const ShuffleException();

  @override
  List<Object?> get props => [];
}
