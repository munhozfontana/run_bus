import 'dart:convert';

import 'package:run_bus/features/domain/entites/reference.dart';

class ReferenceModel extends Reference {
  ReferenceModel({
    required descricao,
    required sequencialRef,
    required tipo,
  }) : super(
          descricao: descricao,
          sequencialRef: sequencialRef,
          tipo: tipo,
        );

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'sequencialRef': sequencialRef,
      'tipo': tipo,
    };
  }

  factory ReferenceModel.fromMap(Map<String, dynamic> map) {
    return ReferenceModel(
      descricao: map['descricao'],
      sequencialRef: map['sequencialRef'],
      tipo: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferenceModel.fromJson(String source) =>
      ReferenceModel.fromMap(json.decode(source));
}
