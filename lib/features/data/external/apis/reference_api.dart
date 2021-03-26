import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/http_adapter.dart';
import 'package:run_bus/features/data/models/reference_model.dart';

abstract class IReferenceApi {
  Future<ReferenceModel> findReferenceByDistrict(String district);
}

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
      if (res.body != null) {
        return ReferenceModel.fromMap(json.decode(res.body).first);
      } else {
        throw ApiException();
      }
    } catch (e) {
      throw ApiException();
    }
  }
}
