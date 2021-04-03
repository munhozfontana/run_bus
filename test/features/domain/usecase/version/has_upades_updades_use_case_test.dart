import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/version.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';
import 'package:run_bus/features/domain/usecase/version/has_upades_updades_use_case.dart';

import 'has_upades_updades_use_case_test.mocks.dart';

@GenerateMocks([
  IVersionRepository,
  IVersionDatabaseRepository,
])
void main() {
  HasUpadesUpdadesUseCase? hasUpadesUpdadesUseCase;
  IVersionRepository? mockIVersionRepository;
  IVersionDatabaseRepository? mockIVersionDatabaseRepository;

  setUp(() {
    mockIVersionRepository = MockIVersionRepository();
    mockIVersionDatabaseRepository = MockIVersionDatabaseRepository();
    hasUpadesUpdadesUseCase = HasUpadesUpdadesUseCase(
        apiRepository: mockIVersionRepository!,
        dbRepository: mockIVersionDatabaseRepository!);
  });
  mockLastVersion(Either<Failure, Version?> value) {
    when(mockIVersionRepository!.lastVersion()).thenAnswer((_) async => value);
  }

  mockLastVersionDB(Either<Failure, Version?> value) {
    when(mockIVersionDatabaseRepository!.lastVersion())
        .thenAnswer((_) async => value);
  }

  group('when api fails', () {
    test('tuble3 <Failure, false, null>', () async {
      mockLastVersion(Left(AppFailure()));
      var result = await hasUpadesUpdadesUseCase!(Params());
      expect(result, equals(Tuple3(AppFailure(), false, null)));
    });
  });

  group('when api success', () {
    group('db fails', () {
      test('tuble3 <Failure, false, null> db fails', () async {
        mockLastVersion(Right(Version(data: 1, sequencial: 1)));
        mockLastVersionDB(Left(AppFailure()));
        var result = await hasUpadesUpdadesUseCase!(Params());
        expect(result, equals(Tuple3(AppFailure(), false, null)));
      });

      test('tuble3 <null, true, 0> db fails with ValueNotFoundFailure',
          () async {
        mockLastVersion(Right(Version(data: 1, sequencial: 1)));
        mockLastVersionDB(Left(ValueNotFoundFailure()));
        var result = await hasUpadesUpdadesUseCase!(Params());
        expect(result, equals(Tuple3(null, true, 0)));
      });
    });
    group('db success', () {
      test('tuble3 <null, true, sequencial> when apiVersion> when api is > db',
          () async {
        mockLastVersion(Right(Version(data: 1, sequencial: 2)));
        mockLastVersionDB(Right(Version(data: 1, sequencial: 1)));
        var result = await hasUpadesUpdadesUseCase!(Params());
        expect(result, equals(Tuple3(null, true, 2)));
      });

      test(
          'tuble3 <null, false, sequencial> when apiVersion> when api is =< db',
          () async {
        mockLastVersion(Right(Version(data: 1, sequencial: 1)));
        mockLastVersionDB(Right(Version(data: 1, sequencial: 1)));
        var result = await hasUpadesUpdadesUseCase!(Params());
        expect(result, equals(Tuple3(null, false, 1)));
      });
    });
  });
}
