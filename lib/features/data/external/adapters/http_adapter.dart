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
