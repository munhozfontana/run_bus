abstract class ILocationAdapter {
  Future<LocationAdapterResponse> getCurrentPosition();
}

class LocationAdapterResponse {
  final double latitude;
  final double longitude;

  LocationAdapterResponse({this.latitude, this.longitude});
}
