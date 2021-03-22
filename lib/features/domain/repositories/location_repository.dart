import 'package:run_bus/features/data/models/location_model.dart';

abstract class ILocationRepository {
  Future<LocationModel> getCurrentLocation();
}
