import 'package:equatable/equatable.dart';
import 'package:run_bus/features/domain/entites/position.dart';

class UserLocation extends Equatable {
  final String district;
  final Location location;

  UserLocation({this.district, this.location});

  @override
  List<Object> get props => [
        district,
        location,
      ];
}
