import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/caloriespage.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:project_wearable_technologies/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/databaseRepository.dart';
import '../screen/loginpage.dart';

List<BottomNavyBarItem> listBottomNavyBarItem = [
  BottomNavyBarItem(
    icon: const Icon(MdiIcons.home),
    title: const Text('Home'),
    activeColor: Palette.color1,
  ),
  BottomNavyBarItem(icon: const Icon(Icons.favorite_border_sharp), title: const Text('Calories'), activeColor: Palette.color4),
  BottomNavyBarItem(icon: const Icon(Icons.bedtime), title: const Text('Sleep'), activeColor: Palette.color3),
  BottomNavyBarItem(icon: const Icon(MdiIcons.pokeball), title: const Text('DayCare'), activeColor: Palette.color2),
  BottomNavyBarItem(icon: const Icon(MdiIcons.logout), title: const Text('Settings'), activeColor: Palette.color5),
];

void changePage(BuildContext context, idx) {
  List<String> listNamePages = [
    Homepage.routename,
    HeartPage.routename,
    Sleeppage.routename,
    Gamepage.routename,
  ];

  if (idx == 4) {
    logOut(context);
  } else {
    Navigator.pushNamed(context, listNamePages[idx]);
  }
}

void logOut(BuildContext context) {
  showDialog<String>(
      context: context,
      builder: (buildContext) => AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              children: const [
                Text(
                  'All the data will be deleted',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Are you sure?',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.remove('user');
                      await Provider.of<DatabaseRepository>(context, listen: false).removeAllPkmn();
                      await Provider.of<DatabaseRepository>(context, listen: false).clearActivity();
                      await FitbitConnector.unauthorize(
                        clientID: Strings.fitbitClientID,
                        clientSecret: Strings.fitbitClientSecret,
                      ).then((value) => {Navigator.of(context).popUntil(ModalRoute.withName(Loginpage.routename))});
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No'),
                  ),
                ],
              )
            ],
          ));
}
