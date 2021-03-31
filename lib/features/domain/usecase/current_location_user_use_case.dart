import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/data/external/drivers/location_verify_adapter.dart';
import 'package:run_bus/features/domain/entites/integration_area.dart';
import 'package:run_bus/features/domain/entites/position.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/integration_area_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, UserLocation>> call(Params params);
}

class CurrentLocationUserUseCase implements UseCase<Type, Params> {
  final ILocationRepository iLocationRepository;
  final IGeocodingRepository iGeocodingRepository;
  final IReferenceRepository iReferenceRepository;
  final IIntegrationAreaRepository iIntegrationAreaRepository;
  final ILocationVerifyAdapter iLocationVerifyAdapter;

  CurrentLocationUserUseCase({
    @required this.iLocationRepository,
    @required this.iGeocodingRepository,
    @required this.iReferenceRepository,
    @required this.iIntegrationAreaRepository,
    @required this.iLocationVerifyAdapter,
  });

  @override
  Future<Either<Failure, UserLocation>> call(Params params) async {
    var location = iLocationRepository.getCurrentLocation;
    var integrationArea = iIntegrationAreaRepository.findIntegrationArea;

    return (await location()).fold(
      (l) {
        log("Falha ao tentar acessar a localização do usuário");
        return null;
      },
      (resLocation) async {
        return (await integrationArea()).fold(
          (l) async {
            return await _findUserLocationByGeocoding(resLocation);
          },
          (r) {
            return _findUserLocationByLocationVerify(r, resLocation);
          },
        );
      },
    );
  }

  Right<Failure, UserLocation> _findUserLocationByLocationVerify(
      List<IntegrationArea> r, Location resLocation) {
    var res = iLocationVerifyAdapter.neaestPoint(r, resLocation);
    return Right(
      UserLocation(location: resLocation, district: res.descricao),
    );
  }

  Future<FutureOr<Either<Failure, UserLocation>>> _findUserLocationByGeocoding(
      Location resLocation) async {
    var reference = iReferenceRepository.findReferenceByDistrict;
    var geocoding = iGeocodingRepository.coordToAndress;

    return (await geocoding(
      resLocation.latitude,
      resLocation.longitude,
    ))
        .fold(
      (l) {
        log('Erro ao tentar acessar geocoding');
        return null;
      },
      (r) async {
        return (await reference(r)).fold(
          (l) => null,
          (r) => Right(UserLocation(
            district: r.toJson(),
            location: resLocation,
          )),
        );
      },
    );
  }

  Future<Either<Failure, List<IntegrationArea>>> teste() {
    return iIntegrationAreaRepository.findIntegrationArea();
  }
}
