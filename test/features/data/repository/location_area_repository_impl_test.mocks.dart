// Mocks generated by Mockito 5.0.3 from annotations
// in run_bus/test/features/data/repository/location_area_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart'
    as _i2;
import 'package:run_bus/features/data/models/location_area_model.dart' as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [ILocationArea].
///
/// See the documentation for Mockito's code generation for more information.
class MockILocationArea extends _i1.Mock implements _i2.ILocationArea {
  MockILocationArea() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.LocationAreaModel>> findLocationArea() =>
      (super.noSuchMethod(Invocation.method(#findLocationArea, []),
              returnValue: Future.value(<_i4.LocationAreaModel>[]))
          as _i3.Future<List<_i4.LocationAreaModel>>);
}
