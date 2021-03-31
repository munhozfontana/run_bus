import 'package:geocoding/geocoding.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/adapters/geocoding_adapter.dart';

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
