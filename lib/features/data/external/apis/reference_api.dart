import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/http_adapter.dart';
import 'package:run_bus/features/data/external/adapters/reference_api.dart';
import 'package:run_bus/features/data/models/reference_model.dart';

class ReferenceApi implements IReferenceApi {
  final HttpAdapter httpAdapter;
  ReferenceApi({
    @required this.httpAdapter,
  });

  @override
  Future<ReferenceModel> findReferenceByDistrict(String district) async {
    try {
      var res = await httpAdapter.getHttp(
          'https://www.sistemas.dftrans.df.gov.br/referencia/find/RA : $district');
      return ReferenceModel.fromMap(json.decode(res.body).first);
    } catch (e) {
      throw ApiException();
    }
  }
}
