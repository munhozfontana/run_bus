import 'package:equatable/equatable.dart';
import 'package:run_bus/features/domain/entites/version.dart';

class Params extends Equatable {
  late final Version version;

  @override
  List<Object> get props => [version];
}
