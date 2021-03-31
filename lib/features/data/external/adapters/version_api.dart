abstract class IVersionApi {
  Future<int> lastVersion();
}

abstract class IVersionDatabase extends IVersionApi {
  Future<int> saveVersion(int version);
}
