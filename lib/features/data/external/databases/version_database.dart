import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/external/databases/app_database.dart';
import 'package:run_bus/features/data/models/version_model.dart';

class VersionDatabase implements IVersionDatabase {
  final IHttp iHttp;

  AppDatabase? db;

  VersionDatabase({
    required this.iHttp,
  }) {
    init();
  }

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
  }

  @override
  Future<int> lastVersion() async {
    var res = await db!.versionDao.selectLastVersion();
    return res.first.sequencial;
  }

  @override
  Future<void> saveVersion(int? version) {
    return db!.versionDao.insertVersion(VersionModel(
      sequencial: version!,
      createAtMillis: DateTime.now().millisecondsSinceEpoch,
    ));
  }
}

@dao
abstract class VersionDao {
  @insert
  Future<void> insertVersion(VersionModel person);

  @Query('SELECT * FROM VersionModel')
  Future<List<VersionModel>> selectLastVersion();
}
