import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/geocoding_adapter.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';

class GeocodingRepository implements IGeocodingRepository {
  final IGeocodingAdapter iGeocodingAdapter;

  GeocodingRepository({@required this.iGeocodingAdapter});

  @override
  Future<String> coordToAndress(lng, lon) async {
    try {
      var res = await iGeocodingAdapter.coordToAndress(lng, lon);
      return res.district;
    } catch (e) {
      throw DriverException();
    }
  }
}
