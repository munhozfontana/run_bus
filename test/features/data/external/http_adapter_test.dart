import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/http_adapter.dart';

import 'http_adapter_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  HttpAdapterImpl httpAdapterImpl;
  http.Client client;
  http.Response anyResponse;
  //PARAMS
  String anyUrl;
  String anyBody;
  int anyStatusCode;
  Map<String, String> anyHeader;

  setUp(() {
    client = MockClient();
    httpAdapterImpl = HttpAdapterImpl(client: client);
    anyBody = json.encode({'any_param': 'anyValue'});
    anyStatusCode = 200;
    anyUrl = 'ANY_URL';
    anyHeader = <String, String>{'ANY_KEY': 'ANY_VALUE'};
    anyResponse = http.Response(
      anyBody,
      anyStatusCode,
    );
  });

  // mocks
  void mockGet() {
    when(client.get(any, headers: anyHeader)).thenAnswer(
      (_) async => anyResponse,
    );
  }

  void mockPut() {
    when(client.put(any, headers: anyHeader)).thenAnswer(
      (_) async => anyResponse,
    );
  }

  void mockPost() {
    when(client.post(any, headers: anyHeader)).thenAnswer(
      (_) async => anyResponse,
    );
  }

  void mockDelete() {
    when(client.delete(any, headers: anyHeader)).thenAnswer(
      (_) async => anyResponse,
    );
  }

  group('success', () {
    test('get', () async {
      mockGet();
      var res = await httpAdapterImpl.getHttp(anyUrl, headers: anyHeader);
      expect(res.body, jsonDecode(anyBody));
    });
    test('put', () async {
      mockPut();
      var res = await httpAdapterImpl.putHttp(anyUrl, headers: anyHeader);
      expect(res.body, jsonDecode(anyBody));
    });
    test('post', () async {
      mockPost();
      var res = await httpAdapterImpl.postHttp(anyUrl, headers: anyHeader);
      expect(res.body, jsonDecode(anyBody));
    });
    test('delete', () async {
      mockDelete();
      var res = await httpAdapterImpl.deleteHttp(anyUrl, headers: anyHeader);
      expect(res.body, jsonDecode(anyBody));
    });
  });

  group('error', () {
    test('get', () {
      expect(
        httpAdapterImpl.getHttp(anyUrl, headers: anyHeader),
        throwsA(isA<ApiAdaptertException>()),
      );
    });
    test('put', () {
      expect(
        httpAdapterImpl.putHttp(anyUrl, headers: anyHeader),
        throwsA(isA<ApiAdaptertException>()),
      );
    });
    test('post', () {
      expect(
        httpAdapterImpl.postHttp(anyUrl, headers: anyHeader),
        throwsA(isA<ApiAdaptertException>()),
      );
    });
    test('delete', () {
      expect(
        httpAdapterImpl.deleteHttp(anyUrl, headers: anyHeader),
        throwsA(isA<ApiAdaptertException>()),
      );
    });
  });
}
