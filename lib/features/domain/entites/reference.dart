import 'dart:convert';

import 'package:equatable/equatable.dart';

class Reference extends Equatable {
  final String descricao;
  final int sequencialRef;
  final String tipo;

  Reference({this.descricao, this.sequencialRef, this.tipo});

  @override
  List<Object> get props => [
        descricao,
        sequencialRef,
        tipo,
      ];

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'sequencialRef': sequencialRef,
      'tipo': tipo,
    };
  }

  factory Reference.fromMap(Map<String, dynamic> map) {
    return Reference(
      descricao: map['descricao'],
      sequencialRef: map['sequencialRef'],
      tipo: map['tipo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Reference.fromJson(String source) =>
      Reference.fromMap(json.decode(source));
}
