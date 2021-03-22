import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// General failures
class ServerFailure extends Failure {
  final String detail;

  ServerFailure({this.detail});

  @override
  List<Object> get props => [detail];
}
