import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/screen/infopage.dart';
import 'package:project_wearable_technologies/screen/loginpage.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';

// prova github desktop

void main() {
  runApp(const MyApp());
} //main

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Loginpage.routename,
      routes: {
        Loginpage.routename: (context) => const Loginpage(),
        Homepage.routename: (context) => const Homepage(),
        Infopage.routename: (context) => const Infopage(),
      },
    );
  } //build
}//MyApp
