import 'dart:convert';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
//import 'package:project_wearable_technologies/classes/pkmn.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:project_wearable_technologies/database/entities/pkmnDb.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/pkmn.dart';
import '../repository/databaseRepository.dart';
import '../utils/palette.dart';
import '../utils/pkmnShop.dart';
import '../utils/utilsBottomNavBar.dart';

class Gamepage extends StatefulWidget {
  const Gamepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'game';
  static const routeForTypes = 'assets/types/';

  @override
  State<Gamepage> createState() => _GamepageState();
}

class _GamepageState extends State<Gamepage> {
  final int _currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseRepository>(
      builder: (context, db, child) {
        return Scaffold(
          body: SafeArea(
            bottom: false,
            child: ListView(
              shrinkWrap: true,
              children: [
                FutureBuilder(
                    future: catchPkmnDayCare(context, db),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<PkmnDb> dayCare = snapshot.data as List<PkmnDb>;
                        return _body(db, dayCare);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Palette.color4,
            onPressed: () => openShop(context),
            label: const Text('Store'),
            icon: const Icon(MdiIcons.store),
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            showElevation: false,
            onItemSelected: (index) => {
              changePage(context, index),
            },
            items: listBottomNavyBarItem,
          ),
        );
      },
    );
  }

  Widget _body(DatabaseRepository db, List<PkmnDb> dayCare) {
    return Column(children: [
      title(),
      Row(
        children: [
          const Expanded(child: SizedBox()),
          dispMoney(),
          const SizedBox(
            width: 50,
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      plotDayCare(context, db, dayCare),
    ]);
  }

  Widget dispMoney() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          SharedPreferences pref = snapshot.data as SharedPreferences;
          int? money = pref.getInt('Money');
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                MdiIcons.currencyBtc,
                size: 18,
              ),
              Text(
                money.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<PkmnDb>?> catchPkmnDayCare(BuildContext context, DatabaseRepository db) async {
    List<PkmnDb>? list = await db.findPkmnDayCare();
    list ??= [];
    return list;
  }

  Widget plotDayCare(BuildContext context, DatabaseRepository db, List<PkmnDb> dayCare) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dayCare.length,
        itemBuilder: (context, idx) {
          PkmnDb pkmn = dayCare[idx];
          return Card(
            elevation: 3,
            child: ListTile(
              leading: Image.network(pkmn.sprite),
              title: plotOnTile(pkmn),
              onTap: () => openPkmn(context, db, pkmn),
            ),
          );
        });
  }

  void openPkmn(BuildContext context, DatabaseRepository db, PkmnDb pkmn) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(child: printPkmnCard(context, db, pkmn));
        });
  }

  Widget printPkmnCard(BuildContext context, DatabaseRepository db, PkmnDb pkmn) {
    const routetypes = 'assets/types/';
    return SizedBox(
      width: 300,
      height: 370,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#' '${pkmn.id}   ' + pkmn.name.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Image.network(
                pkmn.sprite,
                scale: 0.65,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 28,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(routetypes + pkmn.type1 + '.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      pkmn.type2.isNotEmpty ? Image.asset(routetypes + pkmn.type2 + '.png') : const SizedBox()
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Column(
                children: [
                  SizedBox(
                      height: 4,
                      width: 200,
                      child: LinearProgressIndicator(
                        value: pkmn.exp / jsonDecode(pkmn.expToLevelUp)['levels'][pkmn.level]['experience'],
                        color: const Color.fromARGB(255, 140, 243, 71),
                        backgroundColor: const Color.fromARGB(255, 107, 103, 103),
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Lv.' + pkmn.level.toString(), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('Exp:  ' + pkmn.exp.toString() + ' / ' + jsonDecode(pkmn.expToLevelUp)['levels'][pkmn.level]['experience'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 35,
                    child: FloatingActionButton.extended(
                      backgroundColor: Palette.color4,
                      onPressed: () => sellPkmn(context, db, pkmn),
                      label: Row(
                        children: [
                          const Text(
                            'Sell for ',
                            style: TextStyle(fontSize: 17),
                          ),
                          const Icon(
                            MdiIcons.currencyBtc,
                            size: 15,
                          ),
                          Text(
                            pkmn.value.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sellPkmn(BuildContext context, DatabaseRepository db, PkmnDb pkmn) async {
    final pref = await SharedPreferences.getInstance();
    int? money = pref.getInt('Money');
    pref.setInt('Money', money! + pkmn.value);
    await db.removePkmn(pkmn);
    Navigator.pop(context);
  }

  Widget plotOnTile(PkmnDb pkmn) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pkmn.name.toUpperCase().replaceAll('-', ' '), style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                const SizedBox(width: 10),
                const Icon(
                  MdiIcons.currencyBtc,
                  size: 13,
                  color: Colors.grey,
                ),
                Text(
                  pkmn.value.toString(),
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Expanded(
          child: SizedBox(),
        ),
        Text('Lv.' + pkmn.level.toString()),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
            height: 3,
            width: 100,
            child: LinearProgressIndicator(
              value: pkmn.exp / jsonDecode(pkmn.expToLevelUp)['levels'][pkmn.level]['experience'],
              color: const Color.fromARGB(255, 140, 243, 71),
              backgroundColor: const Color.fromARGB(255, 107, 103, 103),
            )),
      ],
    );
  }

  Widget title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Text('Daycare', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Palette.color2, fontFamily: 'Lobster')),
          ],
        ),
      ],
    );
  }
}

Future<Pkmn?> fetchPkmn(dynamic idx) async {
  final String urlPkmn;
  final String urlSpec;

  if (idx is int) {
    urlPkmn = 'https://pokeapi.co/api/v2/pokemon/$idx';
    urlSpec = 'https://pokeapi.co/api/v2/pokemon-species/$idx';
  } else {
    urlPkmn = 'https://pokeapi.co/api/v2/pokemon/' + idx;
    urlSpec = 'https://pokeapi.co/api/v2/pokemon-species/' + idx;
  }

  final responsePkmn = await http.get(Uri.parse(urlPkmn));
  final responseSpec = await http.get(Uri.parse(urlSpec));
  if (responsePkmn.statusCode == 200 && responseSpec.statusCode == 200) {
    var jsonPkmn = jsonDecode(responsePkmn.body);
    var jsonSpec = jsonDecode(responseSpec.body);
    final urlEvol = jsonSpec['evolution_chain']['url'];
    final urlLevel = jsonSpec['growth_rate']['url'];
    final responseEvol = await http.get(Uri.parse(urlEvol));
    final responseLevel = await http.get(Uri.parse(urlLevel));
    if (responseEvol.statusCode == 200 && responseLevel.statusCode == 200) {
      var jsonEvol = jsonDecode(responseEvol.body);
      String jsonLevel = responseLevel.body;
      return Pkmn.fromJson(jsonPkmn, jsonSpec, jsonEvol['chain'], jsonLevel);
    }
  }
  return null;
}
