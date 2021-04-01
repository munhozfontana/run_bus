import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';

abstract class IGeocodingRepository {
  Future<Either<Failure, String?>> coordToAndress(double? lng, double? lon);
}
