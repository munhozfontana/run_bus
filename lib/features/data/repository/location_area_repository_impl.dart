import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';
import 'package:run_bus/features/domain/repositories/integration_area_repository.dart';

class LocationAreaRepository implements ILocationAreaRepository {
  final ILocationArea? iLocationAreaApi;

  LocationAreaRepository({required this.iLocationAreaApi});

  @override
  Future<Either<Failure, List<LocationArea>>> findLocationArea() async {
    try {
      return Right(await iLocationAreaApi!.findLocationArea());
    } on ApiException catch (e) {
      return Left(AppFailure(detail: e.error));
    }
  }
}
