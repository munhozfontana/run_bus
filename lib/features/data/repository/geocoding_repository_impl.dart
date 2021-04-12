import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_geocoding.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';

class GeocodingRepository implements IGeocodingRepository {
  final IGeocoding? driver;

  GeocodingRepository({this.driver});

  @override
  Future<Either<Failure, String?>> coordToAndress(lng, lon) async {
    try {
      var res = await driver!.coordToAndress(lng, lon);
      return Right(res.district);
    } on DriverException catch (e) {
      return Left(AppFailure(detail: e.error));
    }
  }
}
