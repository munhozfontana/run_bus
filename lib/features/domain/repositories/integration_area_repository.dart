import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/entites/integration_area.dart';

abstract class IIntegrationAreaRepository {
  Future<Either<Failure, List<IntegrationArea>>> findIntegrationArea(
      LocationModel location);
}
