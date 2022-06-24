//Imports that are necessary to the code generator of floor

import 'dart:async';
import 'package:floor/floor.dart';
// ignore: unused_import
import 'package:sqflite/sqflite.dart' as sqflite;


//Here, we are importing the entities and the daos of the database
// ignore: unused_import
import 'daos/pkmnDao.dart';
import 'daos/activityDao.dart';
import 'entities/pkmnDb.dart';
import 'entities/activityData.dart';

 //The generated code will be in database.g.dart
part 'database.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Todo
@Database(version: 1, entities: [PkmnDb, ActivityData])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  PkmnDao get pkmnDao;
  ActivityDao get activityDao;
}//AppDatabase