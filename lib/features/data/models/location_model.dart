import 'package:flutter/cupertino.dart';
import 'package:run_bus/features/domain/entites/position.dart';

class LocationModel extends Location {
  LocationModel({
    @required latitude,
    @required longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );
}
