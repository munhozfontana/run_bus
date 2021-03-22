import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, UserLocation>> call(Params params);
}

class CurrentLocationUserUseCase implements UseCase<Type, Params> {
  final ILocationRepository iLocationRepository;
  final IGeocodingRepository iGeocodingRepository;

  CurrentLocationUserUseCase({
    @required this.iLocationRepository,
    @required this.iGeocodingRepository,
  });

  @override
  Future<Either<Failure, UserLocation>> call(Params params) async {
    try {
      var location = await iLocationRepository.getCurrentLocation();
      var district = await iGeocodingRepository.coordToAndress(
        location.latitude,
        location.longitude,
      );
      return Right(
        UserLocation(
          location: location,
          district: district,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(detail: ""));
    }
  }
}
