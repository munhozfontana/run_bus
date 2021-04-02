import 'package:run_bus/features/data/models/version_model.dart';

abstract class IVersion {
  Future<VersionModel?> lastVersion();
}

abstract class IVersionDatabase extends IVersion {
  Future<void> saveVersion(int? version);
}
