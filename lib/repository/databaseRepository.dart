import 'package:project_wearable_technologies/database/database.dart';
import 'package:flutter/material.dart';

import '../database/entities/pkmnDb.dart';
import '../database/entities/activityData.dart';

class DatabaseRepository extends ChangeNotifier {
  final AppDatabase database;

  DatabaseRepository({required this.database});

  Future<List<PkmnDb>?> findAllPkmn() async {
    final results = await database.pkmnDao.findAllPkmn();
    return results;
  }

  Future<void> addPkmn(PkmnDb pkmn) async {
    pkmn.isShop = false;
    List<PkmnDb>? dayCare = await database.pkmnDao.findPkmnDayCare();
    dayCare ??= []; 
    pkmn.entry =  dayCare.where((e) => e.id == pkmn.id).length;
    await database.pkmnDao.addPkmn(pkmn);
    notifyListeners();
  }

  Future<void> addPkmnToShop(PkmnDb pkmn) async {
    pkmn.isShop = true;
    pkmn.entry = -1;
    await database.pkmnDao.addPkmn(pkmn);
    notifyListeners();
  }

  Future<void> removeAllPkmn() async {
    await database.pkmnDao.removeAllPkmn();
    notifyListeners();
  }

  Future<void> removePkmn(PkmnDb pkmn) async {
    await database.pkmnDao.removePkmn(pkmn);
    notifyListeners();
  }

  Future<void> removePkmnFromShop(PkmnDb pkmn) async {
    await database.pkmnDao.removePkmnFromShop(pkmn);
    notifyListeners();
  }

  Future<void> updatePkmn(PkmnDb pkmn) async{
    await database.pkmnDao.updatePkmn(pkmn);
    notifyListeners();
  }

  Future<List<PkmnDb>?> findPkmnShop() async {
    final pkmn = await database.pkmnDao.findPkmnShop();
    return pkmn;
  }

  Future<void> removeListPkmn(List<PkmnDb> pkmn)async{
    await database.pkmnDao.removeListPkmn(pkmn);
  }

  Future<List<PkmnDb>?> findPkmnDayCare() async {
    final pkmn = await database.pkmnDao.findPkmnDayCare();
    return pkmn;
  }

  Future<List<ActivityData>?> findAllUpdates() async {
    final results = await database.activityDao.findAllUpdates();
    return results;
  }

  Future<int> insertUpdate(ActivityData update) async {
    int idx = await database.activityDao.insertUpdate(update);
    notifyListeners();
    return idx;
  }

  Future<ActivityData?> findUpdateById(int id) async {
    ActivityData? update = await database.activityDao.findUpdateById(id);
    return update;
  }

  Future<void> clearActivity() async {
    await database.activityDao.clearActivity();
    notifyListeners();
  }

}//DatabaseRepository