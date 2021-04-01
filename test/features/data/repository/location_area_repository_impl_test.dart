import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart';
import 'package:run_bus/features/data/repository/location_area_repository_impl.dart';

@GenerateMocks([ILocationArea])
void main() {
  LocationAreaRepository locationAreaRepository;
  ILocationArea? mockILocationArea;

  setUp(() {
    // mockILocationArea = MockILocationArea();
    locationAreaRepository = LocationAreaRepository(
      iLocationAreaApi: mockILocationArea,
    );
  });

  test('Sould return Reference with no erros', () async {
    expect(true, false);
  });

  test('Should Thows ApiExpetion when any erros', () async {
    expect(true, false);
  });
}
