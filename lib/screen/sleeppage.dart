import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:project_wearable_technologies/utils/textSleep.dart';

import '../utils/buttonRowBar.dart';
import '../utils/plotSleep.dart';
import '../utils/utilsBottomNavBar.dart';

class Sleeppage extends StatefulWidget {
  const Sleeppage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'sleep';

  @override
  State<Sleeppage> createState() => _SleeppageState();
}

class _SleeppageState extends State<Sleeppage> {
  @override
  void initState() {
    super.initState();
    TextSleep.positionButtonBar = -1;
    ButtonRowBarState.isSelected = [false, false, false];
  }

  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    double _widthButtonBar = MediaQuery.of(context).size.width * 0.8;
    double _heightBar = 25;
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              SizedBox(
                child: plotSleep(context, refresh),
                height: 300,
              ),
              const SizedBox(
                height: 23,
              ),
              TimeSeriesSleep.yesterday.isEmpty ? const SizedBox() : TextSleep(context, heightBar: _heightBar, widthBar: _widthButtonBar)
            ],
          ),
        ]),
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
            Text('Sleep', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Palette.color3, fontFamily: 'Lobster')),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
      ],
    );
  }
  refresh() {
    setState(() {});
  }
}
