import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/reference_api.dart';
import 'package:run_bus/features/domain/entites/reference.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';

class ReferenceRepository implements IReferenceRepository {
  final IReferenceApi iReferenceApi;

  ReferenceRepository({@required this.iReferenceApi});

  @override
  Future<Either<Failure, Reference>> findReferenceByDistrict(
      String district) async {
    try {
      return Right(await iReferenceApi.findReferenceByDistrict(district));
    } on ApiException catch (e) {
      return Left(ServerFailure(detail: e.error));
    }
  }
}
