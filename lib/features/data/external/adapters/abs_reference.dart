import 'package:run_bus/features/data/models/reference_model.dart';

abstract class IReference {
  Future<ReferenceModel> findReferenceByDistrict(String? district);
}
