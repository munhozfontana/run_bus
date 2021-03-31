import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/http_adapter.dart';
import 'package:run_bus/features/data/external/adapters/version_api.dart';

class VersionApi implements IVersionApi {
  final HttpAdapter httpAdapter;
  VersionApi({
    @required this.httpAdapter,
  });

  @override
  Future<int> lastVersion() async {
    try {
      var res = await httpAdapter
          .getHttp('https://www.sistemas.dftrans.df.gov.br/carga/ultima');
      return json.decode(res.body)['data'];
    } catch (e) {
      throw ApiException();
    }
  }
}
