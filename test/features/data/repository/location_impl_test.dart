import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_location.dart';
import 'package:run_bus/features/data/external/drivers/location_adapter.dart';
import 'package:run_bus/features/data/repository/location_repository_impl.dart';

import 'location_impl_test.mocks.dart';

@GenerateMocks([LocationAdapter])
void main() {
  LocationRepository location;
  LocationAdapter mockLocationManager;
  Future<LocationResponse> tResponseFromApi;

  setUp(() {
    tResponseFromApi = Future.value(
      LocationResponse(latitude: 15.31513, longitude: -13.5513),
    );
    mockLocationManager = MockLocationAdapter();
    location = LocationRepository(
      locationAdapter: mockLocationManager,
    );
  });

  test('should capture current location with no erros', () async {
    when(mockLocationManager.getCurrentPosition())
        .thenAnswer((_) => tResponseFromApi);
    expect(await location.getCurrentLocation(), isA<Right>());
  });

  test('should throw error DriverException', () async {
    when(mockLocationManager.getCurrentPosition()).thenThrow(DriverException());
    expect(await location.getCurrentLocation(), isA<Left>());
  });
}
