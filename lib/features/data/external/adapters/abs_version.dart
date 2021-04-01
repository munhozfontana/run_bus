abstract class IVersion {
  Future<int?> lastVersion();
}

abstract class IVersionDatabase extends IVersion {
  Future<void> saveVersion(int? version);
}
