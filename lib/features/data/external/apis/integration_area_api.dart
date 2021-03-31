import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_http.dart';
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart';
import 'package:run_bus/features/data/models/location_area_model.dart';
import 'package:run_bus/features/data/models/location_model.dart';

class LocationAreaApi implements ILocationArea {
  final IHttp iHttp;

  LocationAreaApi({
    @required this.iHttp,
  });

  @override
  Future<List<LocationAreaModel>> findLocationArea() async {
    try {
      var res = await iHttp.getHttp(
          'https://www.sistemas.dftrans.df.gov.br/areaintegracao/geo/areas/wgs');

      var body = json.decode(res.body);

      return List.from(body['features']).map((element) {
        return LocationAreaModel(
          modal: element['properties']['modal'],
          descricao: element['properties']['descricao'],
          location: List.from(
              element['geometry']['coordinates'].first.first.map((element) {
            return LocationModel(
              latitude: element[1],
              longitude: element[0],
            );
          })),
          sequencial: element['properties']['sequencial'],
        );
      }).toList();
    } catch (e) {
      throw ApiException();
    }
  }
}
