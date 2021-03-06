import 'package:http/http.dart' as http;
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/messages/api_mensages.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';

class HttpDriver implements IHttp {
  final http.Client? client;

  HttpDriver({required this.client});

  @override
  Future<HttpResponse> deleteHttp(String? url,
      {Map<String, String>? headers}) async {
    try {
      return mackObj(await client!.delete(Uri.parse(url!), headers: headers));
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  @override
  Future<HttpResponse> getHttp(String? url,
      {Map<String, String>? headers}) async {
    try {
      return mackObj(await client!.get(Uri.parse(url!), headers: headers));
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  @override
  Future<HttpResponse> postHttp(String? url,
      {Map<String, String>? headers, body}) async {
    try {
      return mackObj(
        await client!.post(Uri.parse(url!), headers: headers, body: body),
      );
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  @override
  Future<HttpResponse> putHttp(
    String? url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      return mackObj(
          await client!.put(Uri.parse(url!), headers: headers, body: body));
    } catch (e) {
      throw ApiAdaptertException(error: ApiMensages.ADAPTER_ERROR);
    }
  }

  HttpResponse mackObj(http.Response response) {
    return HttpResponse(
      statusCode: response.statusCode,
      body: response.body,
      header: response.headers,
    );
  }
}
