import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/entites/location.dart';
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
  ILocationAreaRepository,
  ILocationVerifyAdapter
])
void main() {
  late CurrentLocationUserUseCase currentLocationUser;
  MockILocationRepository? mockILocationRepository;
  MockIGeocodingRepository? mockIGeocodingRepository;
  MockIReferenceRepository? mockIReferenceRepository;
  MockILocationAreaRepository? mockILocationAreaRepository;
  MockILocationVerifyAdapter? mockILocationVerifyAdapter;
  Location? tResponse;

  setUp(() {
    tResponse = LocationModel(latitude: 1.0, longitude: 2.0);
    mockILocationRepository = MockILocationRepository();
    mockIGeocodingRepository = MockIGeocodingRepository();
    mockIReferenceRepository = MockIReferenceRepository();
    mockILocationAreaRepository = MockILocationAreaRepository();
    mockILocationVerifyAdapter = MockILocationVerifyAdapter();
    currentLocationUser = CurrentLocationUserUseCase(
        iLocationVerifyAdapter: mockILocationVerifyAdapter,
        iLocationRepository: mockILocationRepository,
        iGeocodingRepository: mockIGeocodingRepository,
        iReferenceRepository: mockIReferenceRepository,
        iLocationAreaRepository: mockILocationAreaRepository);
  });
  test('should return Right with no erros', () async {
    expect(true, false);
  });
  test('should return Left when throw any exption', () async {
    expect(true, false);
  });
}
