import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/version.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Version?>> call(Params params);
}

class TakeLastVersionUseCase implements UseCase<Type, Params> {
  final IVersionRepository apiRepository;

  TakeLastVersionUseCase({required this.apiRepository});

  @override
  Future<Either<Failure, Version?>> call(Params params) async {
    return (await apiRepository.lastVersion());
  }
}
