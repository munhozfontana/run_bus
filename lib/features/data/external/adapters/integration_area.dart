import 'package:run_bus/features/data/models/integration_area_model.dart';

abstract class IIntegrationAreaApi {
  Future<List<IntegrationAreaModel>> findIntegrationArea();
}
