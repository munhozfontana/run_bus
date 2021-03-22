import 'package:geocoding/geocoding.dart';
import 'package:run_bus/core/error/driver_exception.dart';

abstract class IGeocodingAdapter {
  Future<GeocodingAdapterResponse> coordToAndress(double lng, double lon);
}

class GeocodingAdapter implements IGeocodingAdapter {
  @override
  Future<GeocodingAdapterResponse> coordToAndress(
      double lng, double lon) async {
    try {
      var res = await placemarkFromCoordinates(lng, lon);
      return GeocodingAdapterResponse()
        ..district = res.first.subLocality
        ..country = res.first.country
        ..code = res.first.postalCode;
    } catch (e) {
      throw DriverException(error: e.toString());
    }
  }
}

class GeocodingAdapterResponse {
  String district;
  String country;
  String code;
}
