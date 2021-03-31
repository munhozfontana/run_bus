import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/entites/integration_area.dart';
import 'package:run_bus/features/domain/entites/position.dart';
import 'package:run_bus/features/domain/entites/reference.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/integration_area_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';

import 'current_location_user_use_case_test.mocks.dart';

@GenerateMocks([
  ILocationRepository,
  IGeocodingRepository,
  IReferenceRepository,
  IIntegrationAreaRepository,
  ILocationVerifyAdapter
])
void main() {
  CurrentLocationUserUseCase currentLocationUser;
  MockILocationRepository mockILocationRepository;
  MockIGeocodingRepository mockIGeocodingRepository;
  MockIReferenceRepository mockIReferenceRepository;
  MockIIntegrationAreaRepository mockIIntegrationAreaRepository;
  MockILocationVerifyAdapter mockILocationVerifyAdapter;
  FutureOr<Location> tResponse;

  setUp(() {
    tResponse = LocationModel(latitude: 1.0, longitude: 2.0);
    mockILocationRepository = MockILocationRepository();
    mockIGeocodingRepository = MockIGeocodingRepository();
    mockIReferenceRepository = MockIReferenceRepository();
    mockIIntegrationAreaRepository = MockIIntegrationAreaRepository();
    mockILocationVerifyAdapter = MockILocationVerifyAdapter();
    currentLocationUser = CurrentLocationUserUseCase(
        iLocationVerifyAdapter: mockILocationVerifyAdapter,
        iLocationRepository: mockILocationRepository,
        iGeocodingRepository: mockIGeocodingRepository,
        iReferenceRepository: mockIReferenceRepository,
        iIntegrationAreaRepository: mockIIntegrationAreaRepository);
  });
  test('should return Right with no erros', () async {
    when(mockILocationRepository.getCurrentLocation())
        .thenAnswer((_) async => Right(tResponse));

    when(mockIGeocodingRepository.coordToAndress(any, any))
        .thenAnswer((_) async => Right('anyValue'));

    when(mockIReferenceRepository.findReferenceByDistrict(any))
        .thenAnswer((_) async => Right(Reference()));

    when(mockILocationVerifyAdapter.isInside(any, any)).thenAnswer((_) => true);

    when(mockIIntegrationAreaRepository.findIntegrationArea()).thenAnswer(
      (_) async => Right(
        List.generate(
          1,
          (index) => IntegrationArea(
              sequencial: 1,
              modal: '1',
              descricao: '1',
              location: List.generate(
                1,
                (index) => LocationModel(latitude: 1.2, longitude: 3.1),
              )),
        ),
      ),
    );

    expect(await currentLocationUser(Params()), isA<Right>());
  });
  test('should return Left when throw any exption', () async {
    when(mockILocationRepository.getCurrentLocation()).thenThrow(Exception());
    expect(await currentLocationUser(Params()), isA<Left>());
  });
}
