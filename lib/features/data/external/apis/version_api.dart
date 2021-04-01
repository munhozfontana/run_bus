import 'dart:convert';

import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_version.dart';

class VersionApi implements IVersion {
  final IHttp? iHttp;
  VersionApi({
    required this.iHttp,
  });

  @override
  Future<int?> lastVersion() async {
    try {
      var res = await iHttp!
          .getHttp('https://www.sistemas.dftrans.df.gov.br/carga/ultima');
      return json.decode(res.body!)['data'];
    } catch (e) {
      throw ApiException();
    }
  }
}
