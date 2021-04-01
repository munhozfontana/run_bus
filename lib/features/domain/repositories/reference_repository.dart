import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/domain/entites/reference.dart';

abstract class IReferenceRepository {
  Future<Either<Failure, Reference>> findReferenceByDistrict(String? district);
}
