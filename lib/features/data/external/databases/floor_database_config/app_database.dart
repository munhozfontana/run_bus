import 'dart:async';

import 'package:floor/floor.dart';
import 'package:run_bus/features/data/external/databases/version_database.dart';
import 'package:run_bus/features/data/models/version_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [VersionModel])
abstract class AppDatabase extends FloorDatabase {
  VersionDao get versionDao;
}
