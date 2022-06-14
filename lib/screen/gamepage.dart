import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/classes/dayare.dart';
import 'package:project_wearable_technologies/classes/pkmn.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class Gamepage extends StatelessWidget {
  Gamepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'game';
  static const routeForTypes = 'assets/types/';
  var rng = Random();
  DayCare dayCare = DayCare();
  bool isReady = false;
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('count.toString()')
        ),
        body: FutureBuilder(
            future: DayCare.deposit.isEmpty ?  _startADayCare() : null,
            builder: (context, snapshot) {
              if (isReady) {
                return plotDayCare(context, dayCare);
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  Widget plotDayCare(BuildContext context, DayCare dayCare) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: dayCare.howManyPkmn(),
        itemBuilder: (context, idx) {
          Pkmn pkmn = DayCare.deposit[idx];
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
                  Text('Lv.'+pkmn.level.toString()),
                  const SizedBox(width: 2,),
                  SizedBox(
                     height: 3,
                     width: 100,
                      child:
                    LinearProgressIndicator(
                      value: pkmn.exp/pkmn.expToLevel[pkmn.level +1]['experience'],
                      color: const Color.fromARGB(255, 140, 243, 71),
                      backgroundColor: const Color.fromARGB(255, 107, 103, 103),
                     )),
                  
                 // SizedBox(
                   // height: 25,
                   // child: Row(
                    //  children: [
                     //   Image.asset(
                     //     routeForTypes + pkmn.type[0] + '.png',
                     //   ),
                      //  pkmn.type.length > 1 ? Image.asset(routeForTypes + pkmn.type[1] + '.png') : const SizedBox.shrink()
                     // ],
                   // ),
                 // ),
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

  Future<void> _startADayCare() async {
     for (int i = 0; i < 3; i++) {
      int idx = rng.nextInt(899) + 1;
      Pkmn pkmn = await fetchPkmn(idx) as Pkmn;
      dayCare.addPkmn(pkmn);
     }
    isReady = true;
  }
}
