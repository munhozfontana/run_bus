import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, int?>> call(Params params);
}

class UpdadeDataOnInitUseCase implements UseCase<Type, Params> {
  final IVersionRepository iVersionRepositoryApi;
  final IVersionDatabaseRepository? iVersionDatabaseRepository;

  UpdadeDataOnInitUseCase({
    required this.iVersionRepositoryApi,
    required this.iVersionDatabaseRepository,
  });

  @override
  Future<Either<Failure, int?>> call(Params params) async {
    var iVersionApi = await iVersionRepositoryApi.lastVersion();
    var iVersionDatabase = await iVersionDatabaseRepository!.lastVersion();

    if (iVersionApi.isLeft() || iVersionDatabase.isLeft()) {
      return Left(ServerFailure());
    }

    if (iVersionApi.getOrElse(() => null)! >
        iVersionDatabase.getOrElse(() => null)!) {
      iVersionDatabaseRepository!.saveVersion(
        iVersionApi.getOrElse(() => null),
      );
      return Right(iVersionDatabase.getOrElse(() => null));
    } else {
      return iVersionApi;
    }
  }
}
