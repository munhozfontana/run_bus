import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:run_bus/features/domain/entites/version.dart';

@entity
class VersionModel extends Version {
  @primaryKey
  final int? id;

  final int? createAtMillis;

  VersionModel({
    this.id,
    int? sequencial,
    int? data,
    this.createAtMillis,
  }) : super(
          sequencial: sequencial,
          data: data,
        );

  Map<String, dynamic> toMap() {
    return {
      'sequencial': sequencial,
      'data': data,
    };
  }

  factory VersionModel.fromMap(Map<String, dynamic> map) {
    return VersionModel(
      sequencial: map['sequencial'],
      data: map['data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VersionModel.fromJson(String source) =>
      VersionModel.fromMap(json.decode(source));
}
