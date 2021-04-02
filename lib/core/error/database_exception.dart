class DatabaseException implements Exception {
  final String? error;

  DatabaseException({this.error});
}

class DatabaseValueNotFoundException implements DatabaseException {
  final String? error;

  DatabaseValueNotFoundException({this.error});
}

class DatabaseDbClashException implements DatabaseException {
  final String? error;

  DatabaseDbClashException({this.error});
}
