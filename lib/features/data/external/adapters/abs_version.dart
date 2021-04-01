abstract class IVersion {
  Future<int?> lastVersion();
}

abstract class IVersionDatabase extends IVersion {
  Future<int> saveVersion(int? version);
}
