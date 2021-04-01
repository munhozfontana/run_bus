import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

class VersionDatabaseRepository implements IVersionDatabaseRepository {
  final IVersionDatabase iVersionDatabase;

  VersionDatabaseRepository({required this.iVersionDatabase});

  @override
  Future<Either<Failure, int?>> lastVersion() async {
    try {
      return Right(await iVersionDatabase.lastVersion());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>> saveVersion(int? version) async {
    try {
      return Right(await iVersionDatabase.saveVersion(version));
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
