import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// General failures
class AppFailure extends Failure {
  final String? detail;

  AppFailure({this.detail});

  @override
  List<Object?> get props => [detail];
}

class ValueNotFoundFailure extends Failure {
  final String? detail;

  ValueNotFoundFailure({this.detail});

  @override
  List<Object?> get props => [detail];
}

class ValueNotPersisted extends Failure {
  final String? detail;

  ValueNotPersisted({this.detail});

  @override
  List<Object?> get props => [detail];
}
