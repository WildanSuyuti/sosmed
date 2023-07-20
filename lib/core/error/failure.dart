import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnknownFailure extends Failure {
  final String message;

  UnknownFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
