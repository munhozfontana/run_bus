abstract class ILocation {
  Future<LocationResponse> getCurrentPosition();
}

class LocationResponse {
  final double? latitude;
  final double? longitude;

  LocationResponse({this.latitude, this.longitude});
}
