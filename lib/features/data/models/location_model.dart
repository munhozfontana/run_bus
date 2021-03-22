import 'package:flutter/cupertino.dart';
import 'package:run_bus/features/domain/entites/position.dart';

class LocationModel extends Location {
  final double latitude;
  final double longitude;

  LocationModel({
    @required this.latitude,
    @required this.longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );
}
