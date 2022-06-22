import 'package:project_wearable_technologies/database/database.dart';
import 'package:flutter/material.dart';

import '../database/entities/daycare.dart';
import '../database/entities/activityData.dart';

class DatabaseRepository extends ChangeNotifier{

  final AppDatabase database;

  DatabaseRepository({required this.database});

  Future<List<int>?> findAllPkmn() async{
    final results = await database.daycareDao.findAllPkmn();
    return results;
  }

  Future<void> addPkmn(Daycare pkmn) async {
    await database.daycareDao.addPkmn(pkmn);
    notifyListeners();
  }

  Future<void> removePkmn(Daycare pkmn) async{
    await database.daycareDao.removePkmn(pkmn);
    notifyListeners();
  }

  Future<List<ActivityData>?> findAllUpdates() async{
    final results = await database.activityDao.findAllUpdates();
    return results;
  }

  Future<void> insertUpdate(ActivityData update) async {
    await database.activityDao.insertUpdate(update);
    notifyListeners();
  }

  Future<void> clearActivity() async{
    await database.activityDao.clearActivity();
    notifyListeners();
  }
  
}//DatabaseRepository