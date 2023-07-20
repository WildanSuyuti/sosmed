import 'package:logique_test/core/error/failure.dart';

extension FailureExt on Failure {
  String get title {
    if (this is ServerFailure) {
      return 'Server Error';
    } else if (this is NetworkFailure) {
      return 'Connection Lost';
    }
    return 'Oops Something when wrong';
  }

  String get message {
    if (this is ServerFailure) {
      return (this as ServerFailure).message;
    } else if (this is UnknownFailure) {
      return (this as UnknownFailure).message;
    } else if (this is NetworkFailure) {
      return 'Please check your internet connection and try again';
    }
    return 'An error occurred, try again later';
  }
}
