import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/classes/pkmn.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:provider/provider.dart';

import '../database/entities/activityData.dart';
import '../database/entities/pkmnDb.dart';
import '../utils/manageFitBitData.dart';

class Clock {
  static var clock;

  Future<void> startTimer(BuildContext context) async {
    Clock.clock = Timer.periodic(
      const Duration(minutes: 30),
      (Timer t) async {
        await updateDatabase(context);
      },
    );
  }

  void stopClock() {
    Clock.clock.cancel;
  }

  Future<int> updateDatabase(BuildContext context) async {
    var dataCalories = await fetchCaloriesToday();
    int calories = dataCalories[0].value!.toInt();
    var dataSteps = await fetchStepsToday();
    int steps = dataSteps[0].value!.toInt();
    int day = int.parse(DateFormat('dd').format(DateTime.now()));
    int month = int.parse(DateFormat('M').format(DateTime.now()));
    int year = int.parse(DateFormat('y').format(DateTime.now()));
    ActivityData update = ActivityData(null, steps, calories, day, month, year);
    int idxLastUpdate = await Provider.of<DatabaseRepository>(context, listen: false).insertUpdate(update);
    updateDayCare(context, idxLastUpdate, update);
    return idxLastUpdate;
  }

  Future<void> updateDayCare(BuildContext context, int idxLastUpdate, ActivityData lastUpdate) async {
    int totalExp = await calcExpToGive(context, idxLastUpdate, lastUpdate);
    List<PkmnDb>? dayCare = await Provider.of<DatabaseRepository>(context, listen: false).findPkmnDayCare();
    dayCare ??= [];

    for (int i = 0; i < dayCare.length; i++) {
      PkmnDb pkmn = dayCare[i];
      pkmn.totalExpAcquired = pkmn.totalExpAcquired + totalExp;
      List expLevels = jsonDecode(pkmn.expToLevelUp)['levels'];
      PkmnDb updatedPkmn = await processToLevelUp(pkmn, expLevels, totalExp, idxLastUpdate);
      updatedPkmn.idUpdate = idxLastUpdate;
      updatedPkmn.value = updatedPkmn.totalExpAcquired ~/ 50;
      if (pkmn.id == updatedPkmn.id) {
        await Provider.of<DatabaseRepository>(context, listen: false).updatePkmn(updatedPkmn);
      } else {
        await Provider.of<DatabaseRepository>(context, listen: false).removePkmn(pkmn);
        await Provider.of<DatabaseRepository>(context, listen: false).addPkmn(updatedPkmn);
      }
    }
  }

  Future<PkmnDb> processToLevelUp(PkmnDb pkmn, List expLevels, int expToGive, int idxLastUpdate) async {
    int expLevelUp = expLevels[pkmn.level]['experience'];

    if (expToGive + pkmn.exp < expLevelUp) {
      pkmn.exp = pkmn.exp + expToGive;
      return pkmn;
    }

    int residualExp = expToGive - expLevelUp + pkmn.exp;
    pkmn.level = pkmn.level + 1;
    pkmn.exp = 0;

    if (pkmn.nameEvol != null && pkmn.lvEvol != null && pkmn.level >= (pkmn.lvEvol)!.toInt()) {
      Pkmn? pkmnEv = await fetchPkmn(pkmn.nameEvol!);
      String expToLevelUp = pkmnEv!.expToLevel;
      String type1 = pkmnEv.type[0];
      String type2 = '';
      pkmnEv.type.length == 2 ? type2 = pkmnEv.type[1] : null;
      PkmnDb pkmnDb = PkmnDb(
          id: pkmnEv.id,
          totalExpAcquired: pkmn.totalExpAcquired,
          level: pkmn.level,
          value: pkmn.value,
          idUpdate: idxLastUpdate,
          expToLevelUp: expToLevelUp,
          sprite: pkmnEv.sprite,
          name: pkmnEv.name,
          isBuyed: pkmn.isBuyed,
          type1: type1,
          type2: type2);
      if (pkmnEv.evolChain != null) {
        pkmnDb.nameEvol = pkmnEv.evolChain!.name;
        pkmnDb.lvEvol = pkmnEv.evolChain!.levelToEvolve;
      }
      pkmn = pkmnDb;
    }
    return await processToLevelUp(pkmn, expLevels, residualExp, idxLastUpdate);
  }

  Future<int> calcExpToGive(BuildContext context, int idxLastUpdate, ActivityData lastUpdate) async {
    int expForStep = 2;
    int expForCal = 2;

    ActivityData? prevUpdate = await Provider.of<DatabaseRepository>(context, listen: false).findUpdateById(idxLastUpdate - 1);

    return prevUpdate == null || prevUpdate.day < lastUpdate.day || prevUpdate.month < lastUpdate.month || prevUpdate.year < lastUpdate.year
        ? expForCal * lastUpdate.calories + expForStep * lastUpdate.steps
        : expForCal * (lastUpdate.calories - prevUpdate.calories) + expForStep * (lastUpdate.steps - prevUpdate.steps);
  }
}
