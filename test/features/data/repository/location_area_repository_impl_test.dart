import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart';
import 'package:run_bus/features/data/repository/location_area_repository_impl.dart';

@GenerateMocks([ILocationArea])
void main() {
  LocationAreaRepository locationAreaRepository;
  ILocationArea mockILocationArea;

  setUp(() {
    // mockILocationArea = MockILocationArea();
    locationAreaRepository = LocationAreaRepository(
      iLocationAreaApi: mockILocationArea,
    );
  });

  // test('Sould return Reference with no erros', () async {
  //   when(mockILocationAreaApi.findLocationArea())
  //       .thenAnswer((_) async => List.generate(
  //           1,
  //           (index) => LocationAreaModel(
  //                 modal: '1',
  //                 descricao: '1',
  //                 location: List.generate(
  //                   1,
  //                   (index) => LocationModel(latitude: 1.2, longitude: 2.1),
  //                 ),
  //                 sequencial: 1,
  //               )));
  //   var res = await LocationAreaRepository.findLocationArea();
  //   expect(res, isA<Right>());
  // });

  // test('Should Thows ApiExpetion when any erros', () async {
  //   when(mockILocationAreaApi.findLocationArea())
  //       .thenThrow(ApiException());
  //   var res = await LocationAreaRepository.findLocationArea();
  //   expect(res, isA<Left>());
  // });
}
