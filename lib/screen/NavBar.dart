import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'gamepage.dart';

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
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.run_circle),
            title: const Text('Steps'),
            // ignore: avoid_returning_null_for_void
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bedtime),
            title: const Text('Sleep'),
            // ignore: avoid_returning_null_for_void
            onTap: () => null,
          ),
          ListTile(
              leading: const Icon(MdiIcons.pokeball),
              title: const Text('To Pokemon'),
              onTap: () {
                Navigator.pushNamed(context, Gamepage.routename);
              }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Log out'),
            // ignore: avoid_returning_null_for_void
            onTap: () => null,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
