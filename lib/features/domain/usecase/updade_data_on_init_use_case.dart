import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, int?>> call(Params params);
}

class UpdadeDataOnInitUseCase implements UseCase<Type, Params> {
  final IVersionRepository apiRepository;
  final IVersionDatabaseRepository dbRepository;

  UpdadeDataOnInitUseCase({
    required this.apiRepository,
    required this.dbRepository,
  });

  @override
  Future<Either<Failure, int?>> call(Params params) async {
    return (await apiRepository.lastVersion()).fold(
      (fail) => Left(fail),
      (resApi) async {
        return (await dbRepository.lastVersion()).fold(
          (fail) => Left(fail),
          (resDb) async {
            if (resApi! > resDb!) {
              await dbRepository.saveVersion(resApi);
              return (await dbRepository.lastVersion()).fold(
                (fail) => Left(fail),
                (resDb) => Right(resDb),
              );
            } else {
              return Right(resDb);
            }
          },
        );
      },
    );
  }
}
