import 'dart:convert';

import 'package:run_bus/features/domain/entites/place.dart';

class PlaceModel extends Place {
  PlaceModel({
    required sequencial,
    required descricao,
  }) : super(
          sequencial: sequencial,
          descricao: descricao,
        );

  Map<String, dynamic> toMap() {
    return {
      'sequencial': sequencial,
      'descricao': descricao,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      sequencial: map['sequencial'],
      descricao: map['descricao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source));
}
