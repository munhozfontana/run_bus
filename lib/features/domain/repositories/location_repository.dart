import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/domain/entites/position.dart';

abstract class ILocationRepository {
  Future<Either<Failure, Location>> getCurrentLocation();
}
