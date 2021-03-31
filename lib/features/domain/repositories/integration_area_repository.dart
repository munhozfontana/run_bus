import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';

abstract class ILocationAreaRepository {
  Future<Either<Failure, List<LocationArea>>> findLocationArea();
}
