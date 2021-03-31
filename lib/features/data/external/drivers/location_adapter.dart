import 'package:geolocator/geolocator.dart';
import 'package:run_bus/features/data/external/adapters/location_adapter.dart';

class LocationAdapter implements ILocationAdapter {
  @override
  Future<LocationAdapterResponse> getCurrentPosition() async {
    var res = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LocationAdapterResponse(
      latitude: res.latitude,
      longitude: res.longitude,
    );
  }
}
