abstract class IGeocoding {
  Future<GeocodingResponse> coordToAndress(double? lng, double? lon);
}

class GeocodingResponse {
  String? district;
  String? country;
  String? code;
}
