import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;

  Location({
    @required this.latitude,
    @required this.longitude,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
      ];
}
