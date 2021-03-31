import 'dart:math';

import 'package:poly/poly.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/core/utils.dart';
import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';

abstract class ILocationVerifyAdapter {
  bool isInside(List<Location> listLocations, Location location);
  LocationArea neaestPoint(
      List<LocationArea> locationArea, Location resLocation);
}

class LocationVerifyAdapter implements ILocationVerifyAdapter {
  @override
  bool isInside(List<Location> listLocations, Location location) {
    try {
      Polygon testPolygon = Polygon(listLocations
          .map((element) => Point(element.latitude, element.longitude))
          .toList());

      return testPolygon
          .isPointInside(Point(location.latitude, location.longitude));
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
                'lat': e.location.first.latitude,
                'lng': e.location.first.longitude
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
