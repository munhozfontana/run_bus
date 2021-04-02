import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/repository/version_repository_database_impl.dart';

import 'version_repository_database_impl_test.mocks.dart';

@GenerateMocks([IVersionDatabase])
void main() {
  late VersionDatabaseRepository? versionDatabaseRepository;
  IVersionDatabase? mockIVersion;

  setUp(() {
    mockIVersion = MockIVersionDatabase();
    versionDatabaseRepository = VersionDatabaseRepository(
      iVersionDatabase: mockIVersion!,
    );
  });

  group('lastVersion', () {
    test('Sould return Version with no erros', () async {
      when(mockIVersion!.lastVersion()).thenAnswer((_) async => 1615433770891);
      var res = await versionDatabaseRepository!.lastVersion();
      expect(res, isA<Right>());
    });

    test('Should Thows ApiExpetion when any erros', () async {
      when(mockIVersion!.lastVersion()).thenThrow(ApiException);
      var res = await versionDatabaseRepository!.lastVersion();
      expect(res, isA<Left>());
    });
  });
  group('lastVersion', () {
    test('Sould return Version with no erros', () async {
      var res = await versionDatabaseRepository!.saveVersion(0);
      expect(res, isA<Right>());
    });

    test('Should Thows ApiExpetion when any erros', () async {
      when(mockIVersion!.saveVersion(any)).thenThrow(ApiException);
      var res = await versionDatabaseRepository!.saveVersion(0);
      expect(res, isA<Left>());
    });
  });
}
