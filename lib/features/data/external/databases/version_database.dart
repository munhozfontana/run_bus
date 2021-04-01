import 'package:floor/floor.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';
import 'package:run_bus/features/data/models/version_model.dart';

class VersionDatabase implements IVersionDatabase {
  final IHttp iHttp;

  VersionDatabase({
    required this.iHttp,
  });

  @override
  Future<int> lastVersion() {
    // TODO: implement lastVersion
    throw UnimplementedError();
  }

  @override
  Future<int> saveVersion(int? version) {
    // TODO: implement saveVersion
    throw UnimplementedError();
  }
}

@dao
abstract class VersionDao {
  @insert
  Future<void> insertVersion(VersionModel person);
}
