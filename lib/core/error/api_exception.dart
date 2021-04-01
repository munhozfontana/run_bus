class ApiException implements Exception {
  final String? error;

  ApiException({this.error});
}

class ApiAdaptertException implements ApiException {
  @override
  final String? error;

  ApiAdaptertException({this.error});
}

class ApiAdaptertParseException implements ApiException {
  @override
  final String? error;

  ApiAdaptertParseException({this.error});
}

class ApiInternetException implements ApiException {
  @override
  final String? error;

  ApiInternetException({this.error});
}
