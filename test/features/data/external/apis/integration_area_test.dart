import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/apis/integration_area_api.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'reference_api_test.mocks.dart';

void main() {
  LocationAreaApi? areaIntegrationApi;
  IHttp? mockIHttp;

  setUp(() {
    mockIHttp = MockIHttp();
    areaIntegrationApi = LocationAreaApi(
      iHttp: mockIHttp,
    );
  });

  group('method findReferenceByLatLng', () {
    test('should return value with no Erros', () async {
      when(mockIHttp!.getHttp(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        return HttpResponse(
          body: fixture('area_integration_api.json'),
        );
      });

      var res = await areaIntegrationApi!.findLocationArea();

      expect(res, isNotNull);
    });

    test('should throws throws ApiException', () {
      when(mockIHttp!.getHttp(any, headers: anyNamed('headers')))
          .thenThrow(Exception());

      var res = areaIntegrationApi!.findLocationArea();

      expect(res, throwsA(isA<ApiException>()));
    });
  });
}
