
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/screen/sleeppage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';

import '../classes/clockTimer.dart';
import '../utils/utilsBottomNavBar.dart';
import 'caloriespage.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pokemon.jpg')
                ),
              ) ,
            child: ListView(
              shrinkWrap: true,
              children: [
                _bodyHomepage(context),
              ],
            ),
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
        height: 20,
      ),
      Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text('      Welcome Back  ', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Palette.color1, fontFamily: 'Lobster')),
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

      ElevatedButton(

        style: ElevatedButton.styleFrom(
          primary: Palette.color4,
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
                'Calories',
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

        style: ElevatedButton.styleFrom(
          primary: Palette.color3,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Sleeppage.routename);
        },

        child: SizedBox(
          width: 100,
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Sleep',
                style: TextStyle(fontSize: 20),
              ),
              Icon(
                Icons.bedtime,
                size: 18,
              ),
            ],
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: SizedBox(
            height: 500,
            //child: plotSleep(context),
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: SizedBox(
            height: 500,
          ),
        ),
      ),
    ],
  );
} //Page



