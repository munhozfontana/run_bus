import 'package:run_bus/features/data/models/location_area_model.dart';

abstract class ILocationArea {
  Future<List<LocationAreaModel>> findLocationArea();
}
