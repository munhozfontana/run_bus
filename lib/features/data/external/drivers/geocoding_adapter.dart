import 'package:geocoding/geocoding.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_geocoding.dart';

class GeocodingAdapter implements IGeocoding {
  @override
  Future<GeocodingResponse> coordToAndress(double lng, double lon) async {
    try {
      var res = await placemarkFromCoordinates(lng, lon);
      return GeocodingResponse()
        ..district = res.first.subLocality
        ..country = res.first.country
        ..code = res.first.postalCode;
    } catch (e) {
      throw DriverException(error: e.toString());
    }
  }
}
