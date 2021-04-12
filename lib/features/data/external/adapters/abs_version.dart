import 'package:run_bus/features/data/models/version_model.dart';

abstract class IVersion {
  Future<VersionModel?> lastVersion();
  Future<void> saveVersion(int? version);
}
