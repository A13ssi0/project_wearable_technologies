import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/heartpage.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/screen/loginpage.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';
import 'package:project_wearable_technologies/screen/steppage.dart';

import 'database/database.dart';
import 'repository/databaseRepository.dart';

Future<void> main() async {
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine.
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = DatabaseRepository(database: database);

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository.
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: const MyApp(),
  ));
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
        Sleeppage.routename: (context) => const Sleeppage(),
        Steppage.routename: (context) => const Steppage(),
        Gamepage.routename: (context) => Gamepage(),
        HeartPage.routename: (context) => HeartPage(),
      },
    );
  }
}//MyApp
