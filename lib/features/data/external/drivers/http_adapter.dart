import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/messages/api_mensages.dart';

abstract class HttpAdapter {
  Future<ResponseAdapter> getHttp(
    String url, {
    Map<String, String> headers,
  });
  Future<ResponseAdapter> putHttp(
    String url, {
    Map<String, String> headers,
    dynamic body,
  });
  Future<ResponseAdapter> postHttp(
    String url, {
    Map<String, String> headers,
    dynamic body,
  });
  Future<ResponseAdapter> deleteHttp(
    String url, {
    Map<String, String> headers,
  });
}

class HttpAdapterImpl implements HttpAdapter {
  final http.Client client;

  HttpAdapterImpl({@required this.client});

  @override
  Future<ResponseAdapter> deleteHttp(String url,
      {Map<String, String> headers}) async {
    try {
      return mackObj(await client.delete(Uri.parse(url), headers: headers));
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  @override
  Future<ResponseAdapter> getHttp(String url,
      {Map<String, String> headers}) async {
    try {
      return mackObj(await client.get(Uri.parse(url), headers: headers));
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  @override
  Future<ResponseAdapter> postHttp(String url,
      {Map<String, String> headers, body}) async {
    try {
      return mackObj(
        await client.post(Uri.parse(url), headers: headers, body: body),
      );
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  @override
  Future<ResponseAdapter> putHttp(
    String url, {
    Map<String, String> headers,
    dynamic body,
  }) async {
    try {
      return mackObj(
          await client.put(Uri.parse(url), headers: headers, body: body));
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  ResponseAdapter mackObj(http.Response response) {
    return ResponseAdapter(
      statusCode: response.statusCode,
      body: response.body,
      header: response.headers,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ResponseAdapter {
  int statusCode;
  String body;
  Map header;
  ResponseAdapter({
    this.statusCode,
    this.body,
    this.header,
  });
}
