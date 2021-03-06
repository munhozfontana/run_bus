import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_connectivity_adapter.dart';
import 'package:run_bus/features/data/external/adapters/abs_integration_area.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';
import 'package:run_bus/features/domain/repositories/integration_area_repository.dart';

class LocationAreaRepository implements ILocationAreaRepository {
  final ILocationArea? api;
  final ILocationArea? db;
  final IConnectivity? iConnectivity;

  LocationAreaRepository({
    this.api,
    this.db,
    this.iConnectivity,
  });

  @override
  Future<Either<Failure, List<LocationArea>>> findLocationArea() async {
    if (await iConnectivity!.isConnected()) {
      try {
        return Right(await api!.findLocationArea());
      } on ApiException catch (_) {
        return Right(await db!.findLocationArea());
      } catch (e) {
        return Left(AppFailure());
      }
    } else {
      try {
        return Right(await db!.findLocationArea());
      } catch (e) {
        return Left(AppFailure());
      }
    }
  }
}
