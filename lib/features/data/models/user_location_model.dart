import 'package:flutter/cupertino.dart';
import 'package:run_bus/features/domain/entites/position.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';

class UserLocationModel extends UserLocation {
  final String district;
  final Location location;

  UserLocationModel({
    @required this.district,
    @required this.location,
  }) : super(
          district: district,
          location: location,
        );
}
