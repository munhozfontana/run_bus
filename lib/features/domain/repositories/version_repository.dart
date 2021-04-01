import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';

abstract class IVersionRepository {
  Future<Either<Failure, int?>> lastVersion();
}

abstract class IVersionDatabaseRepository extends IVersionRepository {
  Future<Either<Failure, void>> saveVersion(int? version);
}
