import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/database_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/models/version_model.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

class VersionDatabaseRepository implements IVersionDatabaseRepository {
  final IVersionDatabase iVersionDatabase;

  VersionDatabaseRepository({required this.iVersionDatabase});

  @override
  Future<Either<Failure, VersionModel?>> lastVersion() async {
    try {
      return Right(await iVersionDatabase.lastVersion());
    } on DatabaseValueNotFoundException catch (e) {
      return Left(ValueNotFoundFailure(detail: e.error));
    } catch (e) {
      return Left(AppFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveVersion(int? version) async {
    try {
      return Right(await iVersionDatabase.saveVersion(version));
    } catch (e) {
      return Left(AppFailure());
    }
  }
}
