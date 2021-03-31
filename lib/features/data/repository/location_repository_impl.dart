import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/driver_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_location.dart';
import 'package:run_bus/features/domain/entites/location.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';

class LocationRepository implements ILocationRepository {
  final ILocation locationAdapter;

  LocationRepository({this.locationAdapter});

  @override
  Future<Either<Failure, Location>> getCurrentLocation() async {
    try {
      var res = await locationAdapter.getCurrentPosition();
      return Right(
        Location(
          latitude: res.latitude,
          longitude: res.longitude,
        ),
      );
    } on DriverException catch (e) {
      return Left(ServerFailure(detail: e.error));
    }
  }
}
