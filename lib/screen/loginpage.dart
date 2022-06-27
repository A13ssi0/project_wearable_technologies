import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatelessWidget {
  const Loginpage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: const Text(Loginpage.routename),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
                onPressed: () async {
                  print(Strings.userId);
                  // Obtain shared preferences.
                  final prefs = await SharedPreferences.getInstance();
                  String? userId = await FitbitConnector.authorize(
                      context: context,
                      clientID: Strings.fitbitClientID,
                      clientSecret: Strings.fitbitClientSecret,
                      redirectUri: Strings.fitbitRedirectUri,
                      callbackUrlScheme: Strings.fitbitCallbackScheme);

                  Strings.writeUserId(userId!);
                  //prefs.setString('user', userId!);

                  Navigator.pushNamed(context, Homepage.routename);
                },
                child: const Text('Tap to Authorize')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
              ),
              onPressed: () async {
                await FitbitConnector.unauthorize(
                  clientID: Strings.fitbitClientID,
                  clientSecret: Strings.fitbitClientSecret,
                );
              },
              child: const Text('Tap to Unauthorize'),
            ),
            ElevatedButton(onPressed: () async => await Provider.of<DatabaseRepository>(context, listen: false).removeAllPkmn(), child: const Text('delete pkmn')),
            ElevatedButton(onPressed: () async => await Provider.of<DatabaseRepository>(context, listen: false).clearActivity(), child: const Text('delete data'))
          ],
        ),
      ),
    );
  }
}

  //build

//Page
