import 'package:flutter_test/flutter_test.dart';
import 'package:run_bus/core/error/database_exception.dart';
import 'package:run_bus/features/data/external/databases/floor_database_config/app_database.dart';
import 'package:run_bus/features/data/external/databases/version_database.dart';

void main() {
  VersionDatabase? versionDatabase;
  AppDatabase? floor;

  setUp(() async {
    floor = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    versionDatabase = VersionDatabase(
      db: floor,
    );
  });

  void insertValue() {
    floor!.database.insert('VersionModel', {
      'createAtMillis': DateTime.now().millisecondsSinceEpoch,
      'sequencial': 3
    });
  }

  test('should return without erros', () async {
    insertValue();
    expect(await versionDatabase!.lastVersion(), isNotNull);
  });

  test('should throws DatabaseValueNotFoundException when value not value',
      () async {
    expect(
      versionDatabase!.lastVersion(),
      throwsA(
        isA<DatabaseValueNotFoundException>(),
      ),
    );
  });

  test('should throws DatabaseException when db is not present', () async {
    await floor!.close();
    expect(
      versionDatabase!.lastVersion(),
      throwsA(
        isA<DatabaseDbClashException>(),
      ),
    );
  });

  tearDown(() async {
    await floor!.close();
  });
}
