import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
import 'package:project_wearable_technologies/screen/steppage.dart';
import 'package:provider/provider.dart';

import '../classes/clockTimer.dart';
import '../classes/pkmn.dart';
import '../database/entities/activityData.dart';
import '../database/entities/pkmnDb.dart';
import '../utils/NavBar.dart';
import '../utils/plotSleep.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Clock().startTimer(context);
    startApp(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(Homepage.routename),
        ),
        drawer: const NavBar(),
        body: PageView(
          controller: _pageController,
          children: [_bodyHomepage(context)],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: false,
          onItemSelected: (index) => {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 1), curve: Curves.fastOutSlowIn),
            changePage(context, index),
          },
          items: listBottomNavyBarItem,
        ));
    //build
  }
}

Widget _bodyHomepage(BuildContext context) {
  return Center(
    child: ListView(children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
  );
} //Page

Future<void> startApp(BuildContext context) async {
  //var numUpdate = await Provider.of<DatabaseRepository>(context, listen: false).findAllUpdates();
  int lastUpdate = 0;
  List<ActivityData>? totalUpdate = await Provider.of<DatabaseRepository>(context, listen: false).findAllUpdates();
  if (totalUpdate!.isEmpty) {
    lastUpdate = await Clock().updateDatabase(context);
  } else {
    totalUpdate.sort((a, b) => a.id!.compareTo(b.id!));
    lastUpdate = totalUpdate.last.id!;
  }

  var rng = Random();
  List<PkmnDb>? kk = await Provider.of<DatabaseRepository>(context, listen: false).findPkmnShop();
  kk ??= [];
  int startingPkmnShop = kk.length;
  List<int> idxChoosen = [];
  for (var i = 0; i < 3 - startingPkmnShop; i++) {
    int value = (rng.nextInt(25) + 10) * 100;
    int id = rng.nextInt(800);
    if (idxChoosen.contains(id)) {
      i -= 1;
    } else {
      idxChoosen.add(id);
      Pkmn? pkmn = await fetchPkmn(id);
      int expToLevelUp = pkmn!.expToLevel[pkmn.level]['experience'];
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
          isShop: true,
          type1: type1,
          type2: type2);
      await Provider.of<DatabaseRepository>(context, listen: false).addPkmn(pkmnDb);
    }
  }
}
