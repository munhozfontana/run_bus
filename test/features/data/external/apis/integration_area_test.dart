import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/apis/integration_area.dart';
import 'package:run_bus/features/data/external/http_adapter.dart';
import 'package:run_bus/features/data/models/location_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'reference_api_test.mocks.dart';

void main() {
  IntegrationAreaApi areaIntegrationApi;
  MockHttpAdapter mockHttpAdapter;

  setUp(() {
    mockHttpAdapter = MockHttpAdapter();
    areaIntegrationApi = IntegrationAreaApi(
      httpAdapter: mockHttpAdapter,
    );
  });

  group('method findReferenceByLatLng', () {
    test('should return value with no Erros', () async {
      when(mockHttpAdapter.getHttp(any, headers: anyNamed('headers')))
          .thenAnswer((_) async {
        return ResponseAdapter(
          body: fixture('area_integration_api.json'),
        );
      });

      var res = await areaIntegrationApi
          .findReferenceByLatLng(LocationModel(latitude: 3.0, longitude: 3.0));

      expect(res, isNotNull);
    });

    test('should throws throws ApiException', () {
      when(mockHttpAdapter.getHttp(any, headers: anyNamed('headers')))
          .thenThrow(Exception());

      var res = areaIntegrationApi
          .findReferenceByLatLng(LocationModel(latitude: 3.0, longitude: 3.0));

      expect(res, throwsA(isA<ApiException>()));
    });
  });
}
