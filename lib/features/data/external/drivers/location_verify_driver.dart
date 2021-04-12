import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/core/utils.dart';
import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';

abstract class ILocationVerifyDriver {
  bool isInside(List<Location>? listLocations, Location? location);
  LocationArea neaestPoint(
      List<LocationArea> locationArea, Location resLocation);
}

class LocationVerifyAdapter implements ILocationVerifyDriver {
  @override
  bool isInside(List<Location>? points, Location? location) {
    try {
      num ax = 0;
      num ay = 0;
      num bx = points![points.length - 1].latitude! - location!.latitude!;
      num by = points[points.length - 1].longitude! - location.longitude!;
      int depth = 0;

      for (int i = 0; i < points.length; i++) {
        ax = bx;
        ay = by;
        bx = points[i].latitude! - location.latitude!;
        by = points[i].longitude! - location.longitude!;

        if (ay < 0 && by < 0) continue;
        if (ay > 0 && by > 0) continue;
        if (ax < 0 && bx < 0) continue;

        num lx = ax - ay * (bx - ax) / (by - ay);

        if (lx == 0) return true;
        if (lx > 0) depth++;
      }

      return (depth & 1) == 1;
    } catch (e) {
      throw DriverException();
    }
  }

  @override
  LocationArea neaestPoint(
      List<LocationArea> locationArea, Location resLocation) {
    if (locationArea.isEmpty) {
      throw DriverException();
    }

    var list = locationArea
        .map((e) => {
              e.sequencial: {
                'lat': e.location!.first.latitude,
                'lng': e.location!.first.longitude
              }
            })
        .map((element) {
      var latLng = element.entries.first.value;
      return {
        'cod': element.entries.first.key,
        'value': Utils.distanceInKmBetweenEarthCoordinates(
          resLocation.latitude,
          resLocation.longitude,
          latLng['lat'],
          latLng['lng'],
        )
      };
    }).toList()
          ..sort((a, b) => a['value'].compareTo(b['value']));

    return locationArea
        .firstWhere((element) => element.sequencial == list.first['cod']);
  }
}
