import 'package:dartz/dartz.dart';
import 'package:run_bus/core/error/failures.dart';
import 'package:run_bus/features/domain/entites/place.dart';

mixin IPlacesRepository {
  Future<Either<Failure, List<Place>>> getAllPlaces();
}
