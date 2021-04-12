import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/models/version_model.dart';
import 'package:run_bus/features/data/repository/utils_repository_impl.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

class VersionRepository implements IVersionRepository {
  final IVersion? api;
  final IVersion? db;
  final UtilsRepositoryImpl? utilsRepository;

  VersionRepository({
    required this.api,
    required this.db,
    required this.utilsRepository,
  });

  Future<Either<Failure, VersionModel?>> lastVersion() async {
    if (await utilsRepository!.internetCheck()) {
      try {
        return Right(await api!.lastVersion());
      } on ApiException catch (_) {
        return Right(await db!.lastVersion());
      } catch (e) {
        return Left(AppFailure());
      }
    } else {
      try {
        return Right(await db!.lastVersion());
      } catch (e) {
        return Left(AppFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> saveVersion(int? version) async {
    try {
      return Right(await db!.saveVersion(version));
    } catch (e) {
      return Left(AppFailure());
    }
  }
}
