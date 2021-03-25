import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
import 'package:run_bus/features/domain/entites/user_location.dart';
import 'package:run_bus/features/domain/repositories/geocoding_repository.dart';
import 'package:run_bus/features/domain/repositories/location_repository.dart';
import 'package:run_bus/features/domain/repositories/reference_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, UserLocation>> call(Params params);
}

class CurrentLocationUserUseCase implements UseCase<Type, Params> {
  final ILocationRepository iLocationRepository;
  final IGeocodingRepository iGeocodingRepository;
  final IReferenceRepository iReferenceRepository;

  CurrentLocationUserUseCase({
    @required this.iLocationRepository,
    @required this.iGeocodingRepository,
    @required this.iReferenceRepository,
  });

  @override
  Future<Either<Failure, UserLocation>> call(Params params) async {
    try {
      var location = (await iLocationRepository.getCurrentLocation())
          .getOrElse(() => null);

      var geocoding = (await iGeocodingRepository.coordToAndress(
              location.latitude, location.longitude))
          .getOrElse(() => null);

      var reference =
          (await iReferenceRepository.findReferenceByDistrict(geocoding));
      print(reference);

      return Right(
        UserLocation(
          location: location,
          district: geocoding,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(detail: ""));
    }
  }
}
