import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_connectivity_adapter.dart';
import 'package:run_bus/features/data/external/adapters/abs_reference.dart';
import 'package:run_bus/features/domain/entites/reference.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';

class ReferenceRepository implements IReferenceRepository {
  final IReference? api;
  final IReference? db;
  final IConnectivity? iConnectivity;

  ReferenceRepository({
    this.api,
    this.db,
    this.iConnectivity,
    IReference? iReferenceApi,
  });

  @override
  Future<Either<Failure, Reference>> findReferenceByDistrict(
      String? district) async {
    if (await iConnectivity!.isConnected()) {
      try {
        return Right(await api!.findReferenceByDistrict(district));
      } on ApiException catch (_) {
        return Right(await db!.findReferenceByDistrict(district));
      } catch (e) {
        return Left(AppFailure());
      }
    } else {
      try {
        return Right(await db!.findReferenceByDistrict(district));
      } catch (e) {
        return Left(AppFailure());
      }
    }
  }
}
