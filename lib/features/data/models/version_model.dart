import 'package:floor/floor.dart';

@entity
class VersionModel {
  @primaryKey
  final int id;

  final int seq;
  final int dat;

  VersionModel(this.id, this.seq, this.dat);
}
