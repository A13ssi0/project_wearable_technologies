import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:provider/provider.dart';

import '../database/entities/activityData.dart';
import '../utils/manageFitBitData.dart';

class Clock {
  Future<void> startTimer(BuildContext context) async {
    Timer.periodic(
      const Duration(minutes: 10),
      (Timer t) async {
        await updateDatabase(context);
      },
    );
  }

  Future<int> updateDatabase(BuildContext context) async {
    var dataCalories = await fetchCaloriesToday();
    int calories = dataCalories[0].value!.toInt();
    int day = int.parse(DateFormat('dd').format(DateTime.now()));
    int month = int.parse(DateFormat('M').format(DateTime.now()));
    int year = int.parse(DateFormat('y').format(DateTime.now()));
    isAnotherDay(day, month, year);
    ActivityData update = ActivityData(null, 0, calories, day, month, year);
    int idxLastUpdate = await Provider.of<DatabaseRepository>(context, listen: false).insertUpdate(update);
    return idxLastUpdate;
  }

  void isAnotherDay(int day, int month, int year){
  }
}

//@Insert (onConflict = OnConflictStrategy.REPLACE)
//final personDao = database.personDao;
//final person = Person(1, 'Frank');
//await personDao.insertPerson(person);
//final result = await personDao.findPersonById(1);