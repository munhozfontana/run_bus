import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/places_repository.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, int?>> call(Params params);
}

class UpdadeDataUseCase implements UseCase<Type, Params> {
  final IVersionRepository iVersionRepository;
  final IPlacesRepository iPlacesRepository;

  UpdadeDataUseCase({
    required this.iVersionRepository,
    required this.iPlacesRepository,
  });

  @override
  Future<Either<Failure, int?>> call(Params params) async {
    (await iPlacesRepository.getAllPlaces()).fold(
      (l) => Left(AppFailure()),
      (r) => null,
    );

    return (await iVersionRepository.lastVersion()).fold(
      (l) => Left(AppFailure()),
      (version) async {
        return (await iVersionRepository.saveVersion(version!.sequencial)).fold(
          (l) => Left(ValueNotPersistedFailure()),
          (r) => Right(version.sequencial),
        );
      },
    );
  }
}
