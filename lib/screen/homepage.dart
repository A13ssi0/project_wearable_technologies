import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:provider/provider.dart';

import '../classes/clockTimer.dart';
import '../classes/pkmn.dart';
import '../database/entities/activityData.dart';
import '../database/entities/pkmnDb.dart';
import '../utils/utilsBottomNavBar.dart';
import 'heartpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Clock().startTimer(context);
    startApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              _bodyHomepage(context),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: false,
          onItemSelected: (index) => {
            changePage(context, index),
          },
          items: listBottomNavyBarItem,
        ));
    //build
  }
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
          Text('Homepage', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Palette.color1, fontFamily: 'Lobster')),
        ],
      ),
    ],
  );
}

Widget _bodyHomepage(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      title(),
      Container(
        child: Image.asset(
          'assets/jigglypuff.gif',
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.deepOrangeAccent,
        ),
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
      const SizedBox(
        height: 50,
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: SizedBox(
            height: 300,
            //child: plotSleep(context),
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
  );
} //Page

Future<void> startApp(BuildContext context) async {
  //await Provider.of<DatabaseRepository>(context, listen: false).removeAllPkmn();
  int lastUpdate = 0;
  List<ActivityData>? totalUpdate = await Provider.of<DatabaseRepository>(context, listen: false).findAllUpdates();
  if (totalUpdate!.isEmpty) {
    lastUpdate = await Clock().updateDatabase(context);
  } else {
    totalUpdate.sort((a, b) => a.id!.compareTo(b.id!));
    lastUpdate = totalUpdate.last.id!;
  }

  var rng = Random();
  List<PkmnDb>? pkmnShop = await Provider.of<DatabaseRepository>(context, listen: false).findPkmnShop();
  pkmnShop ??= [];
  List<int> idxChoosen = [];
  if (pkmnShop.isNotEmpty) {
    await Provider.of<DatabaseRepository>(context, listen: false).removeListPkmn(pkmnShop);
  }

  List k = [1, 10, 100];
  for (var i = 0; i < 3; i++) {
    int value = (rng.nextInt(15) + 20) * 100;
    //int id = rng.nextInt(800);
    int id = k[i];
    if (idxChoosen.contains(id)) {
      i -= 1;
    } else {
      idxChoosen.add(id);
      Pkmn? pkmn = await fetchPkmn(id);
      String expToLevelUp = pkmn!.expToLevel;
      String type1 = pkmn.type[0];
      String type2 = '';
      pkmn.type.length == 2 ? type2 = pkmn.type[1] : null;
      PkmnDb pkmnDb = PkmnDb(
          id: pkmn.id,
          value: value,
          idUpdate: lastUpdate,
          expToLevelUp: expToLevelUp,
          sprite: pkmn.sprite,
          name: pkmn.name,
          isBuyed: false,
          type1: type1,
          type2: type2);

      if (pkmn.evolChain != null) {
        pkmnDb.nameEvol = pkmn.evolChain!.name;
        pkmnDb.lvEvol = pkmn.evolChain!.levelToEvolve;
      }

      await Provider.of<DatabaseRepository>(context, listen: false).addPkmnToShop(pkmnDb);
    }
  }
}
