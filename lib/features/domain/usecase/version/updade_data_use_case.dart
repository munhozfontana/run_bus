import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';
import 'package:run_bus/features/domain/usecase/version/has_upades_updades_use_case.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, int?>> call(Params params);
}

class UpdadeDataUseCase implements UseCase<Type, Params> {
  final IVersionRepository apiRepository;
  final IVersionDatabaseRepository dbRepository;
  final HasUpadesUpdadesUseCase hasUpadesUpdades;

  UpdadeDataUseCase({
    required this.apiRepository,
    required this.dbRepository,
    required this.hasUpadesUpdades,
  });

  @override
  Future<Either<Failure, int?>> call(Params params) async {
    var resHasUpdade = await hasUpadesUpdades(params);

    if (resHasUpdade.value1 != null) {
      return Left(resHasUpdade.value1!);
    }

    if (resHasUpdade.value2 == true) {
      return _saveOnDatabase(resHasUpdade.value3!);
    } else {
      return Right(resHasUpdade.value3!);
    }
  }

  Future<Either<Failure, int?>> _saveOnDatabase(int sequencial) async {
    return (await dbRepository.saveVersion(sequencial)).fold(
      (l) => Left(ValueNotPersisted()),
      (r) => Right(sequencial),
    );
  }
}
