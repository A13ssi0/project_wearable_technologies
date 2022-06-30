import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/utils/palette.dart';

import '../utils/manageFitBitData.dart';
import '../utils/utilsBottomNavBar.dart';

class HeartPage extends StatefulWidget {
  const HeartPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'heart';

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  final int _currentIndex = 1;

  var heartdata = [];
  var heartdatamonth = [];
  @override
  void initState() {
    super.initState();
    loading();
  }

  Future<void> loading() async {
    var data = await fetchHeartDataSettimana();
    var dato = await fetchHeartDataMese();
    if (heartdata.isEmpty) {
      setState(() {
        heartdata = data;
        heartdatamonth = dato;
      });
    }
  }

  String mediaweek() {
    double somma = 0;
    for (var i = 0; i < heartdata.length; i++) {
      if (heartdata[i].caloriesFatBurn != null) {
        somma = somma + heartdata[i].caloriesFatBurn;
      }
    }
    return (somma / heartdata.length).toStringAsFixed(2);
  }

  String mediamonth() {
    double somma = 0;
    for (var i = 0; i < heartdatamonth.length; i++) {
      if (heartdatamonth[i].caloriesFatBurn != null) {
        somma = somma + heartdatamonth[i].caloriesFatBurn;
      }
    }
    return (somma / heartdatamonth.length).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              title(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 12, 8, 0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 400,
                child: (heartdata.isEmpty)
                    ? const Padding(
                        padding: EdgeInsets.all(100),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/jigglypuff.gif',
                          ),
                        ),
                      )
                    : plotHeart(context, heartdata),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(width: 15, child: const Text(''), color: Colors.pinkAccent),
                      Container(child: const Text('caloriesFatBurn'), padding: const EdgeInsets.fromLTRB(3, 0, 0, 0)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Container(width: 15, child: const Text(''), color: Colors.deepOrangeAccent),
                      Container(child: const Text('caloriesCardio'), padding: const EdgeInsets.fromLTRB(3, 0, 0, 0)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Container(width: 15, child: const Text(''), color: Colors.lightBlueAccent),
                      Container(child: const Text('caloriesPeak'), padding: const EdgeInsets.fromLTRB(3, 0, 0, 0)),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text('MeanWeekCaloriesFatBurn: ' + mediaweek(), style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
              Text('MeanMonthCaloriesFatBurn: ' + mediamonth(), style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
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
            Text('Calories', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Palette.color4, fontFamily: 'Lobster')),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
      ],
    );
  }
}

Widget plotHeart(BuildContext context, List heartdata) {
  return BarChart(
    BarChartData(
      gridData: FlGridData(drawVerticalLine: false),
      titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: bottomTitles,
              reservedSize: 42,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          )),
      barGroups: [
        for (var i = 0; i < heartdata.length; i++)
          BarChartGroupData(
            x: i,
            barsSpace: 2,
            barRods: [
              BarChartRodData(
                toY: getvalue(i, 2, heartdata),
                color: Colors.pinkAccent,
              ),
              BarChartRodData(toY: getvalue(i, 4, heartdata), color: Colors.deepOrangeAccent),
              BarChartRodData(
                toY: getvalue(i, 3, heartdata),
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
      ],
    ),
  );
}

double getvalue(int index, int id, List heartdata) {
  if (id == 2) {
    return heartdata[index].caloriesFatBurn;
  }
  if (id == 3) {
    return heartdata[index].caloriesPeak;
  }
  if (id == 4) {
    return heartdata[index].caloriesCardio;
  }
  return 0;
}

Widget bottomTitles(double value, TitleMeta meta) {
  List<String> titles = [
    DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 6))).substring(0, 2),
    DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 5))).substring(0, 2),
    DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 4))).substring(0, 2),
    DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 3))).substring(0, 2),
    DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 2))).substring(0, 2),
    DateFormat('EEEE').format(DateTime.now().subtract(const Duration(days: 1))).substring(0, 2),
    DateFormat('EEEE').format(DateTime.now()).substring(0, 2)
  ];

  Widget text = Text(
    titles[value.toInt()],
    style: const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16,
    child: text,
  );
}
