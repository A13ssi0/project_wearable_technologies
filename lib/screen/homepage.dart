import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/steppage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:provider/provider.dart';

import '../classes/clockTimer.dart';
import '../classes/pkmn.dart';
import '../database/entities/pkmnDb.dart';
import '../utils/NavBar.dart';
import '../utils/plotSleep.dart';
import 'heartpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Clock().startTimer(context);
    //money=5000;
    startApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.color4,
        title: const Text(Homepage.routename),
      ),
      drawer: const NavBar(),
      body: Center(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 64),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Palette.color3),
                  onPressed: () {
                    Navigator.pushNamed(context, HeartPage.routename);
                  },
                  child: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Heart',
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(
                          Icons.favorite,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Steppage.routename);
                },
                child: const Card(
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Text(
                      'Steps',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: SizedBox(
                    height: 300,
                    child: plotSleep(context),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: SizedBox(
                    height: 300,
                    //child: plotHearth(BuildContext context, List heartdata),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
    //build
  }
} //Page

Future<void> startApp(BuildContext context) async {
  int lastUpdate = await Clock().updateDatabase(context); 
  var rng = Random();
  List<PkmnDb>? kk = await Provider.of<DatabaseRepository>(context, listen: false).findPkmnShop();
  kk ??= [];
  int startingPkmnShop = kk.length;
  List<int> idxChoosen = [];
  for (var i = 0; i < 3-startingPkmnShop; i++) {
    int value = (rng.nextInt(25)+10)*100;
    int id = rng.nextInt(800);
    if (idxChoosen.contains(id)) {
      i -= 1;
    } else {
      idxChoosen.add(id);
      Pkmn? pkmn = await Gamepage().fetchPkmn(id);
      int expToLevelUp = pkmn!.expToLevel[pkmn.level]['experience'];
      String type1 = pkmn.type[0];
      String type2 = '';
      pkmn.type.length == 2 ? type2 = pkmn.type[1] : null;
      PkmnDb pkmnDb = PkmnDb(id: pkmn.id, value:value, idUpdate: lastUpdate, expToLevelUp: expToLevelUp, sprite: pkmn.sprite, name: pkmn.name, isShop: true, type1: type1, type2: type2);
      await Provider.of<DatabaseRepository>(context, listen: false).addPkmn(pkmnDb);
    }
  }
}
