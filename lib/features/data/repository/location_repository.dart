import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/features/data/external/location_adapter.dart';
import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';

class LocationRepository implements ILocationRepository {
  final ILocationAdapter locationAdapter;

  LocationRepository({this.locationAdapter});

  @override
  Future<LocationModel> getCurrentLocation() async {
    try {
      var res = await locationAdapter.getCurrentPosition();
      return LocationModel(
        latitude: res.latitude,
        longitude: res.longitude,
      );
    } catch (e) {
      throw DriverException();
    }
  }
}
