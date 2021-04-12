import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/domain/entites/version.dart';

abstract class IVersionRepository {
  Future<Either<Failure, Version?>> lastVersion();
  Future<Either<Failure, void>> saveVersion(int? version);
}
