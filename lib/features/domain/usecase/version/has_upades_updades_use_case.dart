import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Tuple3<Failure?, bool?, int?>> call(Params params);
}

class HasUpadesUpdadesUseCase implements UseCase<Type, Params> {
  final IVersionRepository apiRepository;
  final IVersionDatabaseRepository dbRepository;

  HasUpadesUpdadesUseCase({
    required this.apiRepository,
    required this.dbRepository,
  });

  @override
  Future<Tuple3<Failure?, bool, int?>> call(Params params) async {
    return await (await apiRepository.lastVersion()).fold(
      (fail) => Tuple3(fail, false, null),
      (resApi) async {
        return (await dbRepository.lastVersion()).fold(
          (fail) async {
            if (fail is ValueNotFoundFailure) {
              return Tuple3(null, true, 0);
            } else {
              return Tuple3(fail, false, null);
            }
          },
          (resDb) async {
            if (resApi!.sequencial! > resDb!.sequencial!) {
              return Tuple3(null, true, resApi.sequencial);
            } else {
              return Tuple3(null, false, resApi.sequencial);
            }
          },
        );
      },
    );
  }
}
