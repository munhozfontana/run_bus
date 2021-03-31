import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/features/data/external/adapters/http_adapter.dart';
import 'package:run_bus/features/data/external/adapters/integration_area.dart';
import 'package:run_bus/features/data/models/integration_area_model.dart';
import 'package:run_bus/features/data/models/location_model.dart';

class IntegrationAreaApi implements IIntegrationAreaApi {
  final HttpAdapter httpAdapter;

  IntegrationAreaApi({
    @required this.httpAdapter,
  });

  @override
  Future<List<IntegrationAreaModel>> findIntegrationArea() async {
    try {
      var res = await httpAdapter.getHttp(
          'https://www.sistemas.dftrans.df.gov.br/areaintegracao/geo/areas/wgs');

      var body = json.decode(res.body);

      return List.from(body['features']).map((element) {
        return IntegrationAreaModel(
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
