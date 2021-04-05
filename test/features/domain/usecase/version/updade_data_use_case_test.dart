import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';
import 'package:run_bus/features/domain/usecase/version/has_upades_updades_use_case.dart';
import 'package:run_bus/features/domain/usecase/version/updade_data_use_case.dart';

import 'has_upades_updades_use_case_test.mocks.dart';
import 'updade_data_use_case_test.mocks.dart';

@GenerateMocks([HasUpadesUpdadesUseCase])
void main() {
  UpdadeDataUseCase? updadeDataUseCase;
  IVersionRepository? mockIVersionRepository;
  IVersionDatabaseRepository? mockIVersionDatabaseRepository;
  HasUpadesUpdadesUseCase? mockHasUpadesUpdadesUseCase;

  setUp(() {
    mockIVersionRepository = MockIVersionRepository();
    mockIVersionDatabaseRepository = MockIVersionDatabaseRepository();
    mockHasUpadesUpdadesUseCase = MockHasUpadesUpdadesUseCase();
    updadeDataUseCase = UpdadeDataUseCase(
      apiRepository: mockIVersionRepository!,
      dbRepository: mockIVersionDatabaseRepository!,
      hasUpadesUpdades: mockHasUpadesUpdadesUseCase!,
    );
  });

  test('should return failure when value1 is not null', () async {
    when(mockHasUpadesUpdadesUseCase!(Params()))
        .thenAnswer((_) async => Tuple3(AppFailure(), false, null));
    expect(await updadeDataUseCase!(Params()), isA<Left>());
  });

  test(
      'should call _saveOnDatabase db when value1 is not null and value2 is true',
      () async {
    when(mockHasUpadesUpdadesUseCase!(Params()))
        .thenAnswer((_) async => Tuple3(null, true, 3));
    when(mockIVersionDatabaseRepository!.saveVersion(any))
        .thenAnswer((_) async => Right(3));
    await updadeDataUseCase!(Params());
    verify(await mockIVersionDatabaseRepository!.saveVersion(3)).called(1);
  });
  test('should return Right when value1 is not null and value2 is true',
      () async {
    when(mockHasUpadesUpdadesUseCase!(Params()))
        .thenAnswer((_) async => Tuple3(null, true, 3));
    when(mockIVersionDatabaseRepository!.saveVersion(any))
        .thenAnswer((_) async => Right(3));
    expect(await updadeDataUseCase!(Params()), isA<Right>());
  });
  test('should return Left(ValueNotPersisted) when saveVersion fail', () async {
    when(mockHasUpadesUpdadesUseCase!(Params()))
        .thenAnswer((_) async => Tuple3(null, true, 3));
    when(mockIVersionDatabaseRepository!.saveVersion(any))
        .thenAnswer((_) async => Left(AppFailure()));
    expect(await updadeDataUseCase!(Params()), isA<Left>());
  });

  test('should return right when value2 is false', () async {
    when(mockHasUpadesUpdadesUseCase!(Params()))
        .thenAnswer((_) async => Tuple3(null, false, 3));
    expect(await updadeDataUseCase!(Params()), isA<Right>());
  });
}
