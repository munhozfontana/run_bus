// Mocks generated by Mockito 5.0.3 from annotations
// in run_bus/test/features/domain/usecase/version/updade_data_use_case_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:run_bus/core/error/failures.dart' as _i6;
import 'package:run_bus/core/params/params.dart' as _i7;
import 'package:run_bus/features/domain/repositories/version_repository.dart'
    as _i2;
import 'package:run_bus/features/domain/usecase/version/has_upades_updades_use_case.dart'
    as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeIVersionRepository extends _i1.Fake
    implements _i2.IVersionRepository {}

class _FakeIVersionDatabaseRepository extends _i1.Fake
    implements _i2.IVersionDatabaseRepository {}

class _FakeTuple3<T1, T2, T3> extends _i1.Fake
    implements _i3.Tuple3<T1, T2, T3> {}

/// A class which mocks [HasUpadesUpdadesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockHasUpadesUpdadesUseCase extends _i1.Mock
    implements _i4.HasUpadesUpdadesUseCase {
  MockHasUpadesUpdadesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IVersionRepository get apiRepository =>
      (super.noSuchMethod(Invocation.getter(#apiRepository),
          returnValue: _FakeIVersionRepository()) as _i2.IVersionRepository);
  @override
  _i2.IVersionDatabaseRepository get dbRepository =>
      (super.noSuchMethod(Invocation.getter(#dbRepository),
              returnValue: _FakeIVersionDatabaseRepository())
          as _i2.IVersionDatabaseRepository);
  @override
  _i5.Future<_i3.Tuple3<_i6.Failure?, bool, int?>> call(_i7.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue:
                  Future.value(_FakeTuple3<_i6.Failure?, bool, int?>()))
          as _i5.Future<_i3.Tuple3<_i6.Failure?, bool, int?>>);
}