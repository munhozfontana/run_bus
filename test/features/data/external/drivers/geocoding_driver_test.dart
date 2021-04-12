import 'package:flutter_test/flutter_test.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/drivers/geocoding_driver.dart';

import 'geocoding_driver_test.mocks.dart';

@GenerateMocks([GeocodingAdapterHelper])
void main() {
  MockGeocodingAdapterHelper? mockGeocodingAdapterHelper;
  GeocodingDriver? geocodingAdapter;

  setUp(() {
    mockGeocodingAdapterHelper = MockGeocodingAdapterHelper();
    geocodingAdapter =
        GeocodingDriver(geocodingAdapterHelper: mockGeocodingAdapterHelper!);
  });

  test(
    "should return first placemark",
    () async {
      when(mockGeocodingAdapterHelper!.getFromCoords(any, any))
          .thenAnswer((_) async => [
                Placemark(
                  subLocality: 'subLocality',
                  country: 'country',
                  postalCode: 'postalCode',
                ),
                Placemark(
                  subLocality: 'subLocalityb',
                  country: 'countryb',
                  postalCode: 'postalCodeb',
                ),
              ]);
      expect((await geocodingAdapter!.coordToAndress(3, 3)).country, 'country');
    },
  );
  test(
    "should throw DriverException when throws ane excption",
    () {
      when(mockGeocodingAdapterHelper!.getFromCoords(any, any))
          .thenThrow(Exception);
      expect(geocodingAdapter!.coordToAndress(3, 3),
          throwsA(isA<DriverException>()));
    },
  );
}
