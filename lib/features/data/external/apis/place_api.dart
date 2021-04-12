import 'dart:convert';

import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_places.dart';
import 'package:run_bus/features/data/models/place_model.dart';

class PlaceApi implements IPlaces {
  final IHttp? iHttp;

  PlaceApi({
    required this.iHttp,
  });

  @override
  Future<List<PlaceModel>> getAllPlaces() async {
    try {
      var res = await iHttp!
          .getHttp('https://www.sistemas.dftrans.df.gov.br/regiao/regioes');
      Iterable list = json.decode(res.body!);
      return list.map((e) => PlaceModel.fromMap(e)).toList();
    } catch (e) {
      throw ApiException(error: e.toString());
    }
  }
}
