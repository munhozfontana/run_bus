import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/location_user.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, UserLocation>> call(Params params);
}

class CurrentLocationUserUseCase implements UseCase<Type, Params> {
  @override
  Future<Either<Failure, UserLocation>> call(Params params) async {}
}
