import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/messages/api_mensages.dart';
import 'package:run_bus/features/data/external/adapters/http_adapter.dart';

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
