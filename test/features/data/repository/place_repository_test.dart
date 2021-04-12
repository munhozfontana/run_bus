import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_places.dart';
import 'package:run_bus/features/data/models/place_model.dart';
import 'package:run_bus/features/data/repository/place_repository.dart';

import 'place_repository_test.mocks.dart';

@GenerateMocks([IPlaces])
void main() {
  late PlaceRepository place;
  late IPlaces mockPlaces;

  setUp(() {
    mockPlaces = MockIPlaces();
    place = PlaceRepository(
      api: mockPlaces,
    );
  });

  test('should capture current place with no erros', () async {
    when(mockPlaces.getAllPlaces()).thenAnswer(
        ((_) async => [PlaceModel(sequencial: 1, descricao: 'any')]));
    expect(await place.getAllPlaces(), isA<Right>());
  });

  test('should throw error DriverException', () async {
    when(mockPlaces.getAllPlaces()).thenThrow(ApiException());
    expect(await place.getAllPlaces(), isA<Left>());
  });
}
