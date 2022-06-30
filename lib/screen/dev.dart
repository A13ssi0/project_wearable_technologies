import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/clockTimer.dart';
import '../database/entities/activityData.dart';
import '../repository/databaseRepository.dart';
import '../utils/strings.dart';

class DevPage extends StatelessWidget {
  const DevPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'dev';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DevPage.routename),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await Provider.of<DatabaseRepository>(context, listen: false).removeAllPkmn();
              await Provider.of<DatabaseRepository>(context, listen: false).clearActivity();
              await FitbitConnector.unauthorize(
                clientID: Strings.fitbitClientID,
                clientSecret: Strings.fitbitClientSecret,
              );
              
            },
            child: const Text('Logout'),
          ),
          ElevatedButton(
              onPressed: () async => await Provider.of<DatabaseRepository>(context, listen: false).removeAllPkmn(), child: const Text('delete pkmn')),
          ElevatedButton(
              onPressed: () async => await Provider.of<DatabaseRepository>(context, listen: false).clearActivity(), child: const Text('delete data')),
          ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setInt('Money', 5000);
              },
              child: const Text('set money')),
          ElevatedButton(
              onPressed: () async {
                List<ActivityData>? k = await Provider.of<DatabaseRepository>(context, listen: false).findAllUpdates();
                ActivityData update = k!.last;
                update.steps = update.steps + 50000;
                update.id = null;
                update.day = int.parse(DateFormat('dd').format(DateTime.now()));
                update.month = int.parse(DateFormat('M').format(DateTime.now()));
                update.year = int.parse(DateFormat('y').format(DateTime.now()));
                int idxLastUpdate = await Provider.of<DatabaseRepository>(context, listen: false).insertUpdate(update);
                Clock().updateDayCare(context, idxLastUpdate, update);
              },
              child: const Text('Add 1000 steps'))
        ],
      ),
    );
  } //build
} //Page
