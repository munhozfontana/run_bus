import 'package:flutter_test/flutter_test.dart';
import 'package:run_bus/core/error/database_exception.dart';
import 'package:run_bus/features/data/external/databases/floor_database_config/app_database.dart';
import 'package:run_bus/features/data/external/databases/version_database.dart';
import 'package:run_bus/features/data/models/version_model.dart';

void main() {
  VersionDatabase? versionDatabase;
  AppDatabase? floor;

  setUp(() async {
    floor = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    versionDatabase = VersionDatabase(
      db: floor,
    );
  });

  void insertValue({sequencial = 3}) {
    floor!.database.insert('VersionModel', {
      'createAtMillis': DateTime.now().millisecondsSinceEpoch,
      'sequencial': sequencial
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

  test('should return last version of several', () async {
    insertValue(sequencial: 1);
    insertValue(sequencial: 2);
    insertValue(sequencial: 3);
    var res = await versionDatabase!.lastVersion();
    expect(
      res,
      equals(VersionModel(sequencial: 3, id: 3)),
    );
  });

  tearDown(() async {
    await floor!.close();
  });
}
