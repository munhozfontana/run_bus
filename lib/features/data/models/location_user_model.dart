import 'package:run_bus/features/domain/entites/location_user.dart';

class LocationUserModel extends UserLocation {
  LocationUserModel({
    required district,
    required location,
  }) : super(
          district: district,
          location: location,
        );
}
