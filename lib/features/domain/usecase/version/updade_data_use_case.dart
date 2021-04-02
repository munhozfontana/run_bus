import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';
import 'package:run_bus/features/domain/usecase/version/has_upades_updades_use_case.dart';
import 'package:run_bus/features/domain/usecase/version/take_last_version.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, int?>> call(Params params);
}

class UpdadeDataUseCase implements UseCase<Type, Params> {
  final IVersionRepository apiRepository;
  final IVersionDatabaseRepository dbRepository;
  final HasUpadesUpdadesUseCase hasUpadesUpdades;
  final TakeLastVersionUseCase takeLastVersion;

  UpdadeDataUseCase({
    required this.apiRepository,
    required this.dbRepository,
    required this.hasUpadesUpdades,
    required this.takeLastVersion,
  });

  @override
  Future<Either<Failure, int?>> call(Params params) async {
    if (params.version.sequencial != null) {
      var param = Params();
      var teste = (await takeLastVersion(Params())).fold((l) => null, (r) => r);
      param..version = teste!;
      await hasUpadesUpdades(param);
    }
    return await findWhenNotParam();
  }

  Future<Either<Failure, int?>> findWhenNotParam() async {
    return (await apiRepository.lastVersion()).fold(
      (fail) => Left(fail),
      (resApi) async {
        return (await dbRepository.lastVersion()).fold(
          (fail) => Left(fail),
          (resDb) async {
            if (resApi!.sequencial! > resDb!.sequencial!) {
              await dbRepository.saveVersion(resApi.sequencial!);
              return (await dbRepository.lastVersion()).fold(
                (fail) => Left(fail),
                (resDb) => Right(resDb!.sequencial!),
              );
            } else {
              return Right(resDb.sequencial!);
            }
          },
        );
      },
    );
  }
}
