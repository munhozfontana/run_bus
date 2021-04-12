import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/apis/place_api.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'reference_api_test.mocks.dart';

void main() {
  PlaceApi? placeApi;
  IHttp? mockIHttp;

  setUp(() {
    mockIHttp = MockIHttp();
    placeApi = PlaceApi(
      iHttp: mockIHttp,
    );
  });

  test('should return with no erros', () async {
    when(mockIHttp!.getHttp(any)).thenAnswer(
      (_) async => HttpResponse(
        body: fixture('place.json'),
        statusCode: 200,
      ),
    );
    var res = await placeApi!.getAllPlaces();
    expect(res, isNotNull);
  });

  test('should throws ApiException when thows any erros', () {
    when(mockIHttp!.getHttp(any)).thenThrow(Exception);
    expect(placeApi!.getAllPlaces(), throwsA(isA<ApiException>()));
  });
}
