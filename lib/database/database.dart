import 'dart:async';
import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/pkmnDao.dart';
import 'daos/activityDao.dart';
import 'entities/pkmnDb.dart';
import 'entities/activityData.dart';

part 'database.g.dart';

@Database(version: 1, entities: [PkmnDb, ActivityData])
abstract class AppDatabase extends FloorDatabase {
  PkmnDao get pkmnDao;
  ActivityDao get activityDao;
}
