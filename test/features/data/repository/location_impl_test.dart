import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/location_adapter.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/data/repository/location_repository.dart';

import 'location_impl_test.mocks.dart';

@GenerateMocks([LocationAdapter])
void main() {
  LocationRepository location;
  LocationAdapter mockLocationManager;
  LocationModel tPosition;
  Future<LocationAdapterResponse> tResponseFromApi;

  setUp(() {
    tPosition = LocationModel(
      latitude: 15.31513,
      longitude: -13.5513,
    );
    tResponseFromApi = Future.value(
      LocationAdapterResponse(latitude: 15.31513, longitude: -13.5513),
    );
    mockLocationManager = MockLocationAdapter();
    location = LocationRepository(
      locationAdapter: mockLocationManager,
    );
  });

  test('should capture current location with no erros', () async {
    when(mockLocationManager.getCurrentPosition())
        .thenAnswer((_) => tResponseFromApi);
    expect(await location.getCurrentLocation(), tPosition);
  });

  test('should throw error DriverException', () async {
    when(mockLocationManager.getCurrentPosition())
        .thenThrow((_) => Exception());
    expect(location.getCurrentLocation(), throwsA(isA<DriverException>()));
  });
}