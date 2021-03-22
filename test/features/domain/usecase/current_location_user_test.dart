import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';
import 'package:run_bus/features/domain/usecase/current_location_user_use_case.dart';

import 'current_location_user_test.mocks.dart';

@GenerateMocks([ILocationRepository, IGeocodingRepository])
void main() {
  CurrentLocationUserUseCase currentLocationUser;
  MockILocationRepository mockILocationRepository;
  MockIGeocodingRepository mockIGeocodingRepository;
  FutureOr<LocationModel> tResponse;

  setUp(() {
    tResponse = Future.value(LocationModel(latitude: 1, longitude: 2));
    mockILocationRepository = MockILocationRepository();
    mockIGeocodingRepository = MockIGeocodingRepository();
    currentLocationUser = CurrentLocationUserUseCase(
      iLocationRepository: mockILocationRepository,
      iGeocodingRepository: mockIGeocodingRepository,
    );
  });
  test('should return Right with no erros', () async {
    when(mockILocationRepository.getCurrentLocation())
        .thenAnswer((_) => tResponse);
    when(mockIGeocodingRepository.coordToAndress(any, any))
        .thenAnswer((realInvocation) => Future.value('anyValue'));
    expect(await currentLocationUser(Params()), isA<Right>());
  });
  test('should return Left when throw any exption', () async {
    when(mockILocationRepository.getCurrentLocation()).thenThrow(Exception());
    expect(await currentLocationUser(Params()), isA<Left>());
  });
}
