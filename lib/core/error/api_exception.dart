import 'dart:developer';

class ApiException implements Exception {
  final String? error;

  ApiException({this.error}) {
    log('log me', name: 'my.app.category', error: 'aaaa', level: 1);
  }
}

class ApiAdaptertException implements ApiException {
  @override
  final String? error;

  ApiAdaptertException({this.error}) {
    log('log me', name: 'my.app.category', error: 'aaaa', level: 1);
  }
}

class ApiNotExists implements ApiException {
  @override
  final String? error;

  ApiNotExists({this.error}) {
    log('log me', name: 'my.app.category', error: 'aaaa', level: 1);
  }
}
