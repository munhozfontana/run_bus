import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/entites/position.dart';
import 'package:run_bus/features/domain/entites/reference.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';

import 'current_location_user_use_case_test.mocks.dart';

@GenerateMocks([
  ILocationRepository,
  IGeocodingRepository,
  IReferenceRepository,
])
void main() {
  CurrentLocationUserUseCase currentLocationUser;
  MockILocationRepository mockILocationRepository;
  MockIGeocodingRepository mockIGeocodingRepository;
  MockIReferenceRepository mockIReferenceRepository;
  FutureOr<Location> tResponse;

  setUp(() {
    tResponse = LocationModel(latitude: 1.0, longitude: 2.0);
    mockILocationRepository = MockILocationRepository();
    mockIGeocodingRepository = MockIGeocodingRepository();
    mockIReferenceRepository = MockIReferenceRepository();
    currentLocationUser = CurrentLocationUserUseCase(
      iLocationRepository: mockILocationRepository,
      iGeocodingRepository: mockIGeocodingRepository,
      iReferenceRepository: mockIReferenceRepository,
    );
  });
  test('should return Right with no erros', () async {
    when(mockILocationRepository.getCurrentLocation())
        .thenAnswer((_) async => Right(tResponse));

    when(mockIGeocodingRepository.coordToAndress(any, any))
        .thenAnswer((_) async => Right('anyValue'));

    when(mockIReferenceRepository.findReferenceByDistrict(any))
        .thenAnswer((_) async => Right(Reference()));

    expect(await currentLocationUser(Params()), isA<Right>());
  });
  test('should return Left when throw any exption', () async {
    when(mockILocationRepository.getCurrentLocation()).thenThrow(Exception());
    expect(await currentLocationUser(Params()), isA<Left>());
  });
}
