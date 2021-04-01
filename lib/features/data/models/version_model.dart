import 'package:floor/floor.dart';
import 'package:run_bus/features/domain/entites/version.dart';

@entity
class VersionModel extends Version {
  @primaryKey
  final int? id;

  final int sequencial;
  final int createAtMillis;

  VersionModel({
    this.id,
    required this.sequencial,
    required this.createAtMillis,
  }) : super(
          sequencial: sequencial,
        );
}
