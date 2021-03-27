import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/core/params/params.dart';
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

  CurrentLocationUserUseCase({
    @required this.iLocationRepository,
    @required this.iGeocodingRepository,
    @required this.iReferenceRepository,
    @required this.iIntegrationAreaRepository,
  });

  @override
  Future<Either<Failure, UserLocation>> call(Params params) async {
    try {
      var location = (await iLocationRepository.getCurrentLocation())
          .getOrElse(() => null);

      // var geocoding = (await iGeocodingRepository.coordToAndress(
      //         location.latitude, location.longitude))
      //     .getOrElse(() => null);

      // var reference = (await iReferenceRepository
      //     .findReferenceByDistrict(geocoding.trim()));
      // print(reference);

      (await iIntegrationAreaRepository.findIntegrationArea()).fold(
          print,
          (r) => r.forEach((element) {
                print('${element.descricao} - ${element.sequencial}');
              }));

      return Right(
        UserLocation(
          location: location,
          district: '',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(detail: ""));
    }
  }
}
