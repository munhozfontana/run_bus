import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/apis/reference_api.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'reference_api_test.mocks.dart';

@GenerateMocks([IHttp])
void main() {
  late ReferenceApi areaIntegrationApi;
  IHttp? mockHttpAdapter;

  setUp(() {
    mockHttpAdapter = MockIHttp();
    areaIntegrationApi = ReferenceApi(
      httpAdapter: mockHttpAdapter,
    );
  });

  group('method findReferenceByLatLng', () {
    test('should return value with no Erros', () async {
      when(mockHttpAdapter!.getHttp(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        return HttpResponse(
          body: fixture('referencia_api.json'),
        );
      });

      var res = await areaIntegrationApi.findReferenceByDistrict("any");

      expect(res, isNotNull);
    });

    test('should throws ApiException when body is null', () {
      when(mockHttpAdapter!.getHttp(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        return HttpResponse(
          body: null,
        );
      });

      var res = areaIntegrationApi.findReferenceByDistrict('any');

      expect(res, throwsA(isA<ApiException>()));
    });

    test('should throws ApiException when having any Erros', () {
      when(mockHttpAdapter!.getHttp(any, headers: anyNamed('headers')))
          .thenThrow(Exception());

      var res = areaIntegrationApi.findReferenceByDistrict('any');

      expect(res, throwsA(isA<ApiException>()));
    });
  });
}
