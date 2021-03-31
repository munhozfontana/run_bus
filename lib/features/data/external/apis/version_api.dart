import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';

class VersionApi implements IVersion {
  final IHttp httpAdapter;
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
