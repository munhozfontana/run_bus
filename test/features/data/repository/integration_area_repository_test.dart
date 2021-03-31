import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart';
import 'package:run_bus/features/data/models/integration_area_model.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/data/repository/integration_area_repository_impl.dart';

import 'integration_area_repository_test.mocks.dart';

@GenerateMocks([IIntegrationArea])
void main() {
  IntegrationAreaRepository integrationAreaRepository;
  MockIIntegrationAreaApi mockIIntegrationAreaApi;

  setUp(() {
    mockIIntegrationAreaApi = MockIIntegrationAreaApi();
    integrationAreaRepository = IntegrationAreaRepository(
      iIntegrationAreaApi: mockIIntegrationAreaApi,
    );
  });

  test('Sould return Reference with no erros', () async {
    when(mockIIntegrationAreaApi.findIntegrationArea())
        .thenAnswer((_) async => List.generate(
            1,
            (index) => IntegrationAreaModel(
                  modal: '1',
                  descricao: '1',
                  location: List.generate(
                    1,
                    (index) => LocationModel(latitude: 1.2, longitude: 2.1),
                  ),
                  sequencial: 1,
                )));
    var res = await integrationAreaRepository.findIntegrationArea();
    expect(res, isA<Right>());
  });

  test('Should Thows ApiExpetion when any erros', () async {
    when(mockIIntegrationAreaApi.findIntegrationArea())
        .thenThrow(ApiException());
    var res = await integrationAreaRepository.findIntegrationArea();
    expect(res, isA<Left>());
  });
}
