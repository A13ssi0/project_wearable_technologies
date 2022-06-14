import 'package:project_wearable_technologies/database/database.dart';
import 'package:flutter/material.dart';

import '../database/entities/daycare.dart';
import '../database/entities/steps.dart';

class DatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  //This method wraps the findAllTodos() method of the DAO
  Future<List<int>> findAllPkmn() async{
    final results = await database.daycareDao.findAllPkmn();
    return results;
  }//findAllTodos

  //This method wraps the insertTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> addPkmn(Daycare pkmn) async {
    await database.daycareDao.addPkmn(pkmn);
    notifyListeners();
  }//insertTodo

  //This method wraps the deleteTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removePkmn(Daycare pkmn) async{
    await database.daycareDao.removePkmn(pkmn);
    notifyListeners();
  }//removeTodo



  Future<List<Steps>> findAllUpdates() async{
    final results = await database.stepsDao.findAllUpdates();
    return results;
  }

  Future<void> insertUpdate(Steps update) async {
    await database.stepsDao.insertUpdate(update);
    notifyListeners();
  }

  Future<void> clearSteps() async{
    await database.stepsDao.clearSteps();
    notifyListeners();
  }
  
}//DatabaseRepository