import 'package:flutter_test/flutter_test.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';

void main() {
  LocationVerifyAdapter locationVerifyAdapter;
  List<Location> listLocations;

  setUp(() {
    listLocations = [
      Location(latitude: -5, longitude: 0),
      Location(latitude: -5, longitude: -5),
      Location(latitude: 0, longitude: -5),
      Location(latitude: 5, longitude: -5),
      Location(latitude: 5, longitude: 0),
      Location(latitude: 5, longitude: 5),
      Location(latitude: 0, longitude: 5),
      Location(latitude: -5, longitude: 5),
    ];
    locationVerifyAdapter = LocationVerifyAdapter();
  });

  group('isInside', () {
    test('should return location inside ranger', () {
      expect(
          locationVerifyAdapter.isInside(
            listLocations,
            Location(latitude: 1, longitude: 2),
          ),
          isTrue);
    });

    test('should return location outside ranger', () {
      expect(
          locationVerifyAdapter.isInside(
            listLocations,
            Location(latitude: 6, longitude: 2),
          ),
          isFalse);
    });
  });
  group('neaestPoint', () {
    test('should return near point', () {
      List<LocationArea> integrationArea = [
        LocationArea(
          descricao: '0',
          location: listLocations.map((e) {
            return Location(
                latitude: e.latitude + 30, longitude: e.longitude + 30);
          }).toList(),
          modal: '0',
          sequencial: 0,
        ),
        LocationArea(
          descricao: '1',
          location: listLocations,
          modal: '1',
          sequencial: 1,
        )
      ];
      expect(
          locationVerifyAdapter
              .neaestPoint(integrationArea, Location(latitude: 6, longitude: 2))
              .sequencial,
          1);
    });

    test('should throws DriverException when firt param isEmpty', () {
      expect(
          () => locationVerifyAdapter
              .neaestPoint([], Location(latitude: 6, longitude: 2)),
          throwsA(isA<DriverException>()));
    });
  });
}
