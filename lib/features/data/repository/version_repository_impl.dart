import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/apis/version_api.dart';
import 'package:run_bus/features/domain/repositories/version_repository.dart';

class VersionRepository implements IVersionRepository {
  final IVersionApi iReferenceApi;

  VersionRepository({@required this.iReferenceApi});

  Future<Either<Failure, int>> lastVersion() async {
    try {
      return Right(await iReferenceApi.lastVersion());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
