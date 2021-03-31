abstract class IGeocodingAdapter {
  Future<GeocodingAdapterResponse> coordToAndress(double lng, double lon);
}

class GeocodingAdapterResponse {
  String district;
  String country;
  String code;
}
