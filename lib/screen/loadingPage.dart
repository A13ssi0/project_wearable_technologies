import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/clockTimer.dart';
import '../classes/pkmn.dart';
import '../database/entities/activityData.dart';
import '../database/entities/pkmnDb.dart';
import '../repository/databaseRepository.dart';
import 'gamepage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'loadingpage';

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  String pointLoading = '';
  int cicle = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) {
        loading();
      },
    );
    checkToUpdate(context, timer!);
  }

  @override
  Widget build(BuildContext context) {
    String text = 'Loading ';
    return Scaffold(backgroundColor: Palette.color3, body: _body(context, text + pointLoading));
  }

  void loading() {
    setState(() {
      if (cicle < 7) {
        pointLoading += '.';
        cicle += 1;
      } else {
        pointLoading = '';
        cicle = 0;
      }
    });
  }

  Widget _body(context, String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage(
              'assets/jigglypuff.gif',
            ),
            radius: 150,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 30, color: Palette.color5),
          ),
        ],
      ),
    );
  }
}

Future<void> checkToUpdate(BuildContext context, Timer timer) async {
  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final prefs = await SharedPreferences.getInstance();
  bool? isFirstRun = prefs.getBool('isFirstRun');
  String? lastDay = prefs.getString('LastDay');

  if (isFirstRun! || lastDay != today) {
    await startApp(context);
    prefs.setBool('isFirstRun', false);
    prefs.setString('LastDay', today);
  }
  timer.cancel();
  Navigator.pushNamed(context, Homepage.routename);
}

Future<void> startApp(BuildContext context) async {
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
  final pref = await SharedPreferences.getInstance();
  int moneyPlus = pref.getInt('Money')! * 0.25 ~/ 100 * 100;
  List<int> idxChoosen = [];
  if (pkmnShop.isNotEmpty) {
    await Provider.of<DatabaseRepository>(context, listen: false).removeListPkmn(pkmnShop);
  }

  for (var i = 0; i < 3; i++) {
    int value = ((rng.nextInt(15) + 10) * 100) + moneyPlus;
    int id = rng.nextInt(800);
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
