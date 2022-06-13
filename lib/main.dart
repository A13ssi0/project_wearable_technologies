import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/screen/caloriespage.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/mealpage.dart';
import 'package:project_wearable_technologies/screen/loginpage.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';
import 'package:project_wearable_technologies/screen/steppage.dart';
import 'package:provider/provider.dart';
import 'classes/clockTimer.dart';

// prova github desktop
//prova 2

void main() {
  runApp(const MyApp());
} //main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClockTimer>(
      create: (context) => ClockTimer(),
      child: MaterialApp(
      initialRoute: Loginpage.routename,
      routes: {
        Loginpage.routename: (context) => const Loginpage(),
        Homepage.routename: (context) => const Homepage(),
        Mealpage.routename: (context) => const Mealpage(),
        Caloriespage.routename: (context) => const Caloriespage(),
        Sleeppage.routename: (context) => const Sleeppage(),
        Steppage.routename: (context) => const Steppage(),
        Gamepage.routename: (context) => Gamepage(),
      },
    ),);
  } //build
}//MyApp
