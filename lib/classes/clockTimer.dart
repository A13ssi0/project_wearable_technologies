import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:provider/provider.dart';

import '../database/entities/activityData.dart';
import '../utils/manageFitBitData.dart';

class Clock {
  void startTimer(BuildContext context) {
    Timer.periodic(
      const Duration(minutes: 10),
      (Timer t) {
        updateDatabase(context);
      },
    );
  }

  Future<void> updateDatabase(BuildContext context) async {
    var dataCalories = await fetchCaloriesToday();
    int calories = dataCalories[0].value!.toInt();
    ActivityData update = ActivityData(null, 0, calories);
    await Provider.of<DatabaseRepository>(context, listen: false).insertUpdate(update);
  }
}

//@Insert (onConflict = OnConflictStrategy.REPLACE)
//final personDao = database.personDao;
//final person = Person(1, 'Frank');
//await personDao.insertPerson(person);
//final result = await personDao.findPersonById(1);