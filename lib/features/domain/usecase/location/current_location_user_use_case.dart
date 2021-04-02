import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/domain/entites/location_area.dart';
import 'package:run_bus/features/domain/entites/location_user.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/integration_area_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, UserLocation>?> call(Params params);
}

class CurrentLocationUserUseCase implements UseCase<Type, Params> {
  final ILocationRepository? iLocationRepository;
  final IGeocodingRepository? iGeocodingRepository;
  final IReferenceRepository? iReferenceRepository;
  final ILocationAreaRepository? iLocationAreaRepository;
  final ILocationVerifyAdapter? iLocationVerifyAdapter;

  CurrentLocationUserUseCase({
    required this.iLocationRepository,
    required this.iGeocodingRepository,
    required this.iReferenceRepository,
    required this.iLocationAreaRepository,
    required this.iLocationVerifyAdapter,
  });

  @override
  Future<Either<Failure, UserLocation>?> call(Params params) async {}

  Future<Either<Failure, List<LocationArea>>> teste() {
    return iLocationAreaRepository!.findLocationArea();
  }
}
