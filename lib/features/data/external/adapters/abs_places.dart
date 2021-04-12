import 'package:run_bus/features/data/models/place_model.dart';

abstract class IPlaces {
  Future<List<PlaceModel>> getAllPlaces();
}
