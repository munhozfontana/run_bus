import 'package:run_bus/features/domain/entites/integration_area.dart';
import 'package:run_bus/features/domain/entites/position.dart';

abstract class ILocationVerify {
  bool isInside(List<Location> listLocations, Location location);
  IntegrationArea neaestPoint(
      List<IntegrationArea> integrationArea, Location resLocation);
}
