import 'dart:convert';

import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_reference.dart';
import 'package:run_bus/features/data/models/reference_model.dart';

class ReferenceApi implements IReference {
  final IHttp? iHttp;
  ReferenceApi({
    required this.iHttp,
  });

  @override
  Future<ReferenceModel> findReferenceByDistrict(String? district) async {
    try {
      var res = await iHttp!.getHttp(
          'https://www.sistemas.dftrans.df.gov.br/referencia/find/RA : $district');
      return ReferenceModel.fromMap(json.decode(res.body!).first);
    } catch (e) {
      throw ApiException();
    }
  }
}
