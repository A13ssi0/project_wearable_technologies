import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/heartpage.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';

List<BottomNavyBarItem> listBottomNavyBarItem = [
  BottomNavyBarItem(
    icon: const Icon(MdiIcons.home),
    title: const Text('Home'),
    activeColor: Colors.red,
  ),
  BottomNavyBarItem(
      icon: const Icon(Icons.favorite_border_sharp),
      title: const Text('Heart'),
      activeColor: Colors.purpleAccent),
  BottomNavyBarItem(
      icon: const Icon(Icons.bedtime), title: const Text('Sleep'), activeColor: Colors.pink),
  BottomNavyBarItem(
      icon: const Icon(MdiIcons.pokeball), title: const Text('DayCare'), activeColor: Colors.pink),
  BottomNavyBarItem(
      icon: const Icon(MdiIcons.account), title: const Text('Settings'), activeColor: Colors.blue),
];

void changePage(BuildContext context, idx) {
  List<String> listNamePages = [
    Homepage.routename,
    HeartPage.routename,
    Sleeppage.routename,
    Gamepage.routename,
    ''
  ];

  Navigator.pushNamed(context, listNamePages[idx]);
}
