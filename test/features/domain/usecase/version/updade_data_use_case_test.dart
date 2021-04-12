import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/places_repository.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';
import 'package:run_bus/features/domain/usecase/version/updade_data_use_case.dart';

import 'updade_data_use_case_test.mocks.dart';

@GenerateMocks([
  IVersionRepository,
  IPlacesRepository,
])
void main() {
  UpdadeDataUseCase? updadeDataUseCase;
  IVersionRepository? mockIVersionRepository;
  IPlacesRepository? mockIPlacesRepository;

  setUp(() {
    mockIVersionRepository = MockIVersionRepository();
    mockIPlacesRepository = MockIPlacesRepository();
    updadeDataUseCase = UpdadeDataUseCase(
        iVersionRepository: mockIVersionRepository!,
        iPlacesRepository: mockIPlacesRepository!);
  });

  void makeIPlacesRepository(Either<Failure, List<num>> value) {
    // when(mockIPlacesRepository!.getAllPlaces()).thenAnswer((_) async => value);
  }

  test(
    'should call _saveOnDatabase db when value1 is not null and value2 is true',
    () async {
      makeIPlacesRepository(Right([1, 2]));
      await updadeDataUseCase!(Params());
    },
  );
  test('should return Right when value1 is not null and value2 is true',
      () async {
    makeIPlacesRepository(Right([1, 2]));
    expect(await updadeDataUseCase!(Params()), isA<Right>());
  }, skip: true);
  test('should return Left(ValueNotPersisted) when saveVersion fail', () async {
    makeIPlacesRepository(Right([1, 2]));
    expect(await updadeDataUseCase!(Params()), isA<Left>());
  });

  group('when arrive _saveOnDatase', () {
    test('should return right when value2 is false', () async {
      makeIPlacesRepository(Right([1, 2]));
      expect(await updadeDataUseCase!(Params()), isA<Right>());
    });

    test('should save places', () async {
      makeIPlacesRepository(Right([1, 2]));
      expect(await updadeDataUseCase!(Params()), isA<Right>());
    });
  }, skip: true);
}
