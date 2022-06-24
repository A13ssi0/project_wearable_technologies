import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:project_wearable_technologies/classes/pkmn.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:project_wearable_technologies/database/entities/pkmnDb.dart';
import 'package:provider/provider.dart';

import '../classes/pkmn.dart';
import '../repository/databaseRepository.dart';
import '../utils/pkmnShop.dart';

class Gamepage extends StatelessWidget {
  Gamepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'game';
  static const routeForTypes = 'assets/types/';
  var rng = Random();

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseRepository>(
      builder: (context, db, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('count.toString()')),
          body: Column(
            children: [
              FutureBuilder(
                  future: catchPkmnDayCare(context, db),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PkmnDb> dayCare = snapshot.data as List<PkmnDb>;
                      return plotDayCare(context, dayCare);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              ElevatedButton(onPressed: () => db.removeAllPkmn(), child: const Text('delete'))
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () => openShop(context)),
        );
      },
    );
  }

  Future<List<PkmnDb>?> catchPkmnDayCare(BuildContext context, DatabaseRepository db) async {
    List<PkmnDb>? list = await db.findPkmnDayCare();
    list ??= [];
    return list;
  }

  Widget plotDayCare(BuildContext context, List<PkmnDb> dayCare) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: dayCare.length,
        itemBuilder: (context, idx) {
          PkmnDb pkmn = dayCare[idx];
          return Card(
            elevation: 5,
            child: ListTile(
              leading: Image.network(pkmn.sprite),
              title: Row(
                children: [
                  Text(pkmn.name.toUpperCase().replaceAll('-', ' '), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text('Lv.' + pkmn.level.toString()),
                  const SizedBox(
                    width: 2,
                  ),
                  SizedBox(
                      height: 3,
                      width: 100,
                      child: LinearProgressIndicator(
                        value: pkmn.exp / pkmn.expToLevelUp,
                        color: const Color.fromARGB(255, 140, 243, 71),
                        backgroundColor: const Color.fromARGB(255, 107, 103, 103),
                      )),
                ],
              ),
            ),
          );
        });
  }

  Future<Pkmn?> fetchPkmn(int idx) async {
    final urlPkmn = 'https://pokeapi.co/api/v2/pokemon/$idx';
    final urlSpec = 'https://pokeapi.co/api/v2/pokemon-species/$idx';
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
        var jsonLevel = jsonDecode(responseLevel.body);
        return Pkmn.fromJson(jsonPkmn, jsonSpec, jsonEvol['chain'], jsonLevel);
      }
    }
    return null;
  }
}
