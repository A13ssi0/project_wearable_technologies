import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';
import 'package:project_wearable_technologies/screen/heartpage.dart';

import '../screen/gamepage.dart';
import '../screen/loginpage.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('G.C'),
            accountEmail: Text('@gmail.com'),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border_sharp),
            title: const Text('Heart'),
            // ignore: avoid_returning_null_for_void
            onTap: () => Navigator.pushNamed(context, HeartPage.routename),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bedtime),
            title: const Text('Sleep'),
            // ignore: avoid_returning_null_for_void
            onTap: () => Navigator.pushNamed(context, Sleeppage.routename),
          ),
          ListTile(
            leading: const Icon(MdiIcons.pokeball),
            title: const Text('To Pokemon'),
            onTap: () => Navigator.pushNamed(context, Gamepage.routename),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Log out'),
              // ignore: avoid_returning_null_for_void
              onTap: () async {
                //await logOut();
                //print('exit logout');
                //print(Strings.userId);
                FitbitConnector.unauthorize(
                  clientID: Strings.fitbitClientID,
                  clientSecret: Strings.fitbitClientSecret,
                ).then((value) => {
                      // permette di aspettare infatti ho tolto await
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(Loginpage.routename))
                    });
                // Navigator.of(context)
                //   .popUntil(ModalRoute.withName(Loginpage.routename));
              }),
          const Divider(),
        ],
      ),
    );
  }

  // Future<void> logOut() async {
  // await FitbitConnector.unauthorize(
  // clientID: Strings.userId,
  //clientSecret: Strings.fitbitClientSecret,
  //);
  //final prefs = await SharedPreferences.getInstance();
  //await prefs.remove('user');
  //print('finished logout');
  //}
}
