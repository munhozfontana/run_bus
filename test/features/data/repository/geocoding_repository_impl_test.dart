import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/features/data/external/adapters/abs_geocoding.dart';
import 'package:run_bus/features/data/repository/geocoding_repository_impl.dart';

import 'geocoding_repository_impl_test.mocks.dart';

@GenerateMocks([IGeocoding])
void main() {
  GeocodingRepository geocodingRepository;
  IGeocoding mockIGeocodingAdapter;

  setUp(() {
    mockIGeocodingAdapter = MockIGeocoding();
    geocodingRepository = GeocodingRepository(
      iGeocodingAdapter: mockIGeocodingAdapter,
    );
  });

  test('should return Right with no erros', () async {
    when(mockIGeocodingAdapter.coordToAndress(any, any)).thenAnswer(
        (_) => Future.value(GeocodingResponse()..district = 'anyDistrict'));
    var res = await geocodingRepository.coordToAndress(3.1, 42.2);
    expect(res, isA<Right>());
  });
}
