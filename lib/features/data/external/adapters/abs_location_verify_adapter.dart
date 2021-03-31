import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';

abstract class ILocationVerify {
  bool isInside(List<Location> listLocations, Location location);
  LocationArea neaestPoint(
      List<LocationArea> locationArea, Location resLocation);
}
