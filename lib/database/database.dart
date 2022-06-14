//Imports that are necessary to the code generator of floor
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Here, we are importing the entities and the daos of the database
import 'daos/daycareDao.dart';
import 'daos/stepsDao.dart';
import 'entities/daycare.dart';
import 'entities/steps.dart';

 //The generated code will be in database.g.dart
part 'database.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Todo
@Database(version: 1, entities: [Daycare, Steps])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  DaycareDao get daycareDao;
  StepsDao get stepsDao;
}//AppDatabase