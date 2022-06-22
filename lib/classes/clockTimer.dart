import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/database/database.dart';
import 'package:project_wearable_technologies/database/entities/activityData.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';

class Clock extends ChangeNotifier {
  static var database;

  Future<void> startTimer() async {
    Clock.database = await $FloorAppDatabase.databaseBuilder('database.dart').build();
    Timer.periodic(
      const Duration(seconds: 10),
      (Timer t) async {
        await updateDatabase();
        notifyListeners();
      },
    );
  }

  Future<void> updateDatabase() async {
    AppDatabase db = Clock.database;
    var dataCalories = await fetchCaloriesToday();
    int calories = dataCalories[0].value!.toInt();
    int? howManyRows = await db.activityDao.countRow();
    howManyRows ??= 0;
    ActivityData update = ActivityData(howManyRows, 0, calories);
    await db.activityDao.insertUpdate(update);
  }

  
}


//final personDao = database.personDao;
//final person = Person(1, 'Frank');
//await personDao.insertPerson(person);
//final result = await personDao.findPersonById(1);