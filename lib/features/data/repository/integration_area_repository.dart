import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/api_exception.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/apis/integration_area.dart';
import 'package:run_bus/features/domain/entites/integration_area.dart';
import 'package:run_bus/features/domain/repositories/integration_area_repository.dart';

class IntegrationAreaRepository implements IIntegrationAreaRepository {
  final IIntegrationAreaApi iIntegrationAreaApi;

  IntegrationAreaRepository({@required this.iIntegrationAreaApi});

  @override
  Future<Either<Failure, List<IntegrationArea>>> findIntegrationArea() async {
    try {
      return Right(await iIntegrationAreaApi.findIntegrationAreabyLocation());
    } on ApiException catch (e) {
      return Left(ServerFailure(detail: e.error));
    }
  }
}
