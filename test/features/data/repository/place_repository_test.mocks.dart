// Mocks generated by Mockito 5.0.3 from annotations
// in run_bus/test/features/data/repository/place_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:run_bus/features/data/external/adapters/abs_places.dart' as _i2;
import 'package:run_bus/features/data/models/place_model.dart' as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [IPlaces].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPlaces extends _i1.Mock implements _i2.IPlaces {
  MockIPlaces() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.PlaceModel>> getAllPlaces() =>
      (super.noSuchMethod(Invocation.method(#getAllPlaces, []),
              returnValue: Future.value(<_i4.PlaceModel>[]))
          as _i3.Future<List<_i4.PlaceModel>>);
}