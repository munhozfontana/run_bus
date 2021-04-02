import 'package:floor/floor.dart';
import 'package:run_bus/core/error/database_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/external/databases/floor_database_config/app_database.dart';
import 'package:run_bus/features/data/models/version_model.dart';

class VersionDatabase implements IVersionDatabase {
  final AppDatabase? db;

  VersionDatabase({required this.db});

  @override
  Future<int?> lastVersion() async {
    var res;
    try {
      res = await db!.versionDao.selectLastVersion();
    } catch (e) {
      throw DatabaseDbClashException();
    }
    if (res.isEmpty) {
      throw DatabaseValueNotFoundException();
    }
    return res.map((item) => item!.id).first;
  }

  @override
  Future<void> saveVersion(int? version) {
    try {
      return db!.versionDao.insertVersion(VersionModel(
        sequencial: version!,
        createAtMillis: DateTime.now().millisecondsSinceEpoch,
      ));
    } catch (e) {
      throw DatabaseException();
    }
  }
}

@dao
abstract class VersionDao {
  @insert
  Future<void> insertVersion(VersionModel person);

  @Query('SELECT * FROM VersionModel')
  Future<List<VersionModel?>> selectLastVersion();
}
