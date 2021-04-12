import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/data/external/adapters/abs_places.dart';
import 'package:run_bus/features/domain/entites/place.dart';
import 'package:run_bus/features/domain/repositories/places_repository.dart';

class PlaceRepository implements IPlacesRepository {
  final IPlaces? api;

  PlaceRepository({
    this.api,
  });

  @override
  Future<Either<Failure, List<Place>>> getAllPlaces() async {
    try {
      return Right(await api!.getAllPlaces());
    } catch (e) {
      return Left(AppFailure());
    }
  }
}
