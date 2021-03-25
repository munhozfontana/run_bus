import 'package:flutter/cupertino.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';

class UserLocationModel extends UserLocation {
  UserLocationModel({
    @required district,
    @required location,
  }) : super(
          district: district,
          location: location,
        );
}
