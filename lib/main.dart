import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/screen/loadingPage.dart';
import 'package:provider/provider.dart';

import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/caloriespage.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/screen/loginpage.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';
import 'package:project_wearable_technologies/screen/dev.dart';

import 'database/database.dart';
import 'repository/databaseRepository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final AppDatabase database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final databaseRepository = DatabaseRepository(database: database);

  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: const MyApp(),
  ));
}

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
        DevPage.routename: (context) => const DevPage(),
        Gamepage.routename: (context) => const Gamepage(),
        HeartPage.routename: (context) => const HeartPage(),
        LoadingPage.routename: (context) => const LoadingPage(),
      },
    );
  }
}
