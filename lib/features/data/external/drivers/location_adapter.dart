import 'package:geolocator/geolocator.dart';
import 'package:run_bus/features/data/external/adapters/abs_location.dart';

class LocationAdapter implements ILocation {
  @override
  Future<LocationResponse> getCurrentPosition() async {
    var res = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LocationResponse(
      latitude: res.latitude,
      longitude: res.longitude,
    );
  }
}
