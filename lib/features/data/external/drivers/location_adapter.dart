import 'package:geolocator/geolocator.dart';

abstract class ILocationAdapter {
  Future<LocationAdapterResponse> getCurrentPosition();
}

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

class LocationAdapterResponse {
  final double latitude;
  final double longitude;

  LocationAdapterResponse({this.latitude, this.longitude});
}
