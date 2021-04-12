import 'package:geocoding/geocoding.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/adapters/abs_geocoding.dart';

class GeocodingDriver implements IGeocoding {
  final GeocodingAdapterHelper geocodingAdapterHelper;

  GeocodingDriver({required this.geocodingAdapterHelper});

  @override
  Future<GeocodingResponse> coordToAndress(double? lng, double? lon) async {
    try {
      var res = await geocodingAdapterHelper.getFromCoords(lng, lon);
      return GeocodingResponse()
        ..district = res.first.subLocality
        ..country = res.first.country
        ..code = res.first.postalCode;
    } catch (e) {
      throw DriverException(error: e.toString());
    }
  }
}

class GeocodingAdapterHelper {
  Future<List<Placemark>> getFromCoords(double? lng, double? lon) =>
      placemarkFromCoordinates(lng!, lon!);
}
