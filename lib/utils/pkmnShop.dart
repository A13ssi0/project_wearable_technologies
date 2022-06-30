import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/entities/pkmnDb.dart';
import '../repository/databaseRepository.dart';

void openShop(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return shop(context);
      });
}

Future<List<PkmnDb>?> catchPkmnShop(BuildContext context, DatabaseRepository db) async {
  List<PkmnDb>? list = await db.findPkmnShop();
  list ??= [];
  return list;
}

Widget shop(BuildContext context) {
  return Consumer<DatabaseRepository>(
    builder: (context, db, child) {
      return FutureBuilder(
          future: catchPkmnShop(context, db),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<PkmnDb> pkmnShop = snapshot.data as List<PkmnDb>;
              return createShop(context, pkmnShop, db);
            } else {
              return const CircularProgressIndicator();
            }
          });
    },
  );
}

Widget createShop(BuildContext context, List<PkmnDb> pkmn, DatabaseRepository db) {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GridView.count(
          childAspectRatio: 0.70,
          shrinkWrap: true,
          crossAxisCount: 3,
          children: List<Widget>.generate(3, (index) {
            return GridTile(
                child: Card(
              child: InkWell(
                onTap: () => buyPkmn(context, pkmn[index], db),
                child: Center(
                  child: printPkmn(context, pkmn[index]),
                ),
              ),
            ));
          })),
      const SizedBox(
        height: 75,
      )
    ],
  );
}

Future<void> buyPkmn(BuildContext context, PkmnDb pkmn, DatabaseRepository db) async {
  final pref = await SharedPreferences.getInstance();
  int? money = pref.getInt('Money');
  PkmnDb pkmnToAdd = pkmn;
  pkmn.isBuyed = true;
  if (money! >= pkmn.value) {
    await db.removePkmnFromShop(pkmn);
    pref.setInt('Money', money - pkmn.value);
    pkmnToAdd.value = 0;
    await db.addPkmn(pkmnToAdd);
    Navigator.pop(context);
  } else {
    dispError(context);
  }
}

void dispError(BuildContext context) {
  Timer _timer = Timer(const Duration(seconds: 6), () {
    Navigator.of(context).pop();
  });
  showDialog(
      context: context,
      builder: (builderContext) {
        return const AlertDialog(
          content: Text('Not enougth money to buy it'),
        );
      }).then((val) {
    if (_timer.isActive) {
      _timer.cancel();
    }
  });
}

Widget printPkmn(BuildContext context, PkmnDb pkmn) {
  const routetypes = 'assets/types/';
  return pkmn.isBuyed == true
      ? const SizedBox()
      : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              '#' '${pkmn.id} ' + pkmn.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Image.network(pkmn.sprite),
            SizedBox(
              height: 22,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(routetypes + pkmn.type1 + '.png')),
                    pkmn.type2.isNotEmpty ? Expanded(child: Image.asset(routetypes + pkmn.type2 + '.png')) : const SizedBox()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  MdiIcons.currencyBtc,
                  size: 15,
                ),
                Text(pkmn.value.toString())
              ],
            )
          ],
        );
}
