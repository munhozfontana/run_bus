import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';

abstract class IVersionRepository {
  Future<Either<Failure, int>> lastVersion();
}
