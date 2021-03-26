import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/apis/integration_area.dart';
import 'package:run_bus/features/data/models/integration_area_model.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/data/repository/integration_area_repository.dart';

import 'integration_area_repository_test.mocks.dart';

@GenerateMocks([IIntegrationAreaApi])
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
    when(mockIIntegrationAreaApi.findReferenceByLatLng(any))
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
    var res = await integrationAreaRepository.findIntegrationArea(LocationModel(
      latitude: 3.0,
      longitude: 3.0,
    ));
    expect(res, isA<Right>());
  });

  test('Should Thows ApiExpetion when any erros', () async {
    when(mockIIntegrationAreaApi.findReferenceByLatLng(any))
        .thenThrow(ApiException());
    var res = await integrationAreaRepository.findIntegrationArea(LocationModel(
      latitude: 3.0,
      longitude: 3.0,
    ));
    expect(res, isA<Left>());
  });
}
