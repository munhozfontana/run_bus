import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/apis/version_api.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'reference_api_test.mocks.dart';

void main() {
  VersionApi versionApi;
  IHttp mockIHttp;

  setUp(() {
    mockIHttp = MockIHttp();
    versionApi = VersionApi(iHttp: mockIHttp);
  });

  test('should return some version', () async {
    when(mockIHttp.getHttp(any))
        .thenAnswer((_) async => HttpResponse(body: fixture('carga.json')));
    expect(await versionApi.lastVersion(), 1615433770891);
  });

  test('should thows ApiException when thows any erros', () {
    when(mockIHttp.getHttp(any)).thenThrow(Exception);
    expect(versionApi.lastVersion(), throwsA(isA<ApiException>()));
  });
}
