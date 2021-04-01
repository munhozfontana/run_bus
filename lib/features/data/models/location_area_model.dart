import 'package:run_bus/features/data/models/location_model.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';

class LocationAreaModel extends LocationArea {
  LocationAreaModel({
    required String? modal,
    required String? descricao,
    required List<LocationModel> location,
    required int? sequencial,
  }) : super(
          modal: modal,
          descricao: descricao,
          location: location,
          sequencial: sequencial,
        );
}
