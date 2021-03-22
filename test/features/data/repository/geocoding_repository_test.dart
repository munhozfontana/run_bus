import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/features/data/external/geocoding_adapter.dart';
import 'package:run_bus/features/data/repository/geocoding_repository.dart';

import 'geocoding_repository_test.mocks.dart';

@GenerateMocks([IGeocodingAdapter])
void main() {
  GeocodingRepository geocodingRepository;
  MockIGeocodingAdapter mockIGeocodingAdapter;

  setUp(() {
    mockIGeocodingAdapter = MockIGeocodingAdapter();
    geocodingRepository = GeocodingRepository(
      iGeocodingAdapter: mockIGeocodingAdapter,
    );
  });

  test('should return Right with no erros', () async {
    when(mockIGeocodingAdapter.coordToAndress(any, any)).thenAnswer((_) =>
        Future.value(GeocodingAdapterResponse()..district = 'anyDistrict'));
    var res = await geocodingRepository.coordToAndress(3.1, 42.2);
    expect(res, 'anyDistrict');
  });
}
