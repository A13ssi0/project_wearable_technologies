import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/manageFitBitData.dart';

class HeartPage extends StatefulWidget {
  //const HeartPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'heart';

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
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

  double mediaweek() {
    double somma = 0;
    double meanweek = 0;
    for (var i = 0; i < heartdata.length; i++) {
      if (heartdata[i].caloriesFatBurn != null) {
        somma = somma + heartdata[i].caloriesFatBurn;
      }
    }
    meanweek = somma / heartdata.length;
    return meanweek;
  }

  double mediamonth() {
    double somma = 0;
    double meanmonth = 0;
    for (var i = 0; i < heartdatamonth.length; i++) {
      if (heartdatamonth[i].caloriesFatBurn != null) {
        somma = somma + heartdatamonth[i].caloriesFatBurn;
      }
    }
    meanmonth = somma / heartdatamonth.length;
    return meanmonth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HeartPage.routename),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              title(),
              (heartdata.isEmpty)
                  ? Container()
                  : plotHearth(context, heartdata),
              Container(
                  margin: const EdgeInsets.fromLTRB(12, 12, 0, 32),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: const Text(''),
                                color: Colors.pinkAccent,
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0)),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                                child: const Text('caloriesFatBurn'),
                                padding: const EdgeInsets.fromLTRB(6, 2, 0, 2)),
                            flex: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: const Text(''),
                                color: Colors.lightBlueAccent,
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0)),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                                child: const Text('caloriesPeak'),
                                padding: const EdgeInsets.fromLTRB(6, 2, 0, 2)),
                            flex: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: const Text(''),
                                color: Colors.deepOrangeAccent,
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0)),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                                child: const Text('caloriesCardio'),
                                padding: const EdgeInsets.fromLTRB(6, 2, 0, 2)),
                            flex: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: const Text(''),
                                color: Colors.white,
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0)),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                                child: Text('MeanWeekCaloriesFatBurn: ' +
                                    mediaweek().toString()),
                                padding: const EdgeInsets.fromLTRB(6, 2, 0, 2)),
                            flex: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: const Text(''),
                                color: Colors.white,
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0)),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                                child: Text('MeanMonthCaloriesFatBurn: ' +
                                    mediamonth().toString()),
                                padding: const EdgeInsets.fromLTRB(6, 2, 0, 2)),
                            flex: 10,
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.cached),
          onPressed: () {
            setState(() {
              heartdata = [];
            });
            loading();
          }),
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
          children: const [
            SizedBox(
              width: 30,
            ),
            Text('Heart',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 40, color: Colors.blue, fontFamily: 'Lobster')),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
      ],
    );
  }
} //Page

Widget plotHearth(BuildContext context, List heartdata) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 12, 8, 0),
    width: MediaQuery.of(context).size.width * 90 / 100,
    height: 400,
    child: BarChart(
      BarChartData(
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
              x: i, //
              barsSpace: 2,
              barRods: [
                //BarChartRodData(
                // toY: getvalue(i,1),
                //color: Colors.lightGreen,

                //),
                BarChartRodData(
                  toY: getvalue(i, 2, heartdata),
                  color: Colors.pinkAccent,
                ),
                BarChartRodData(
                  toY: getvalue(i, 3, heartdata),
                  color: Colors.lightBlueAccent,
                ),
                BarChartRodData(
                    toY: getvalue(i, 4, heartdata),
                    color: Colors.deepOrangeAccent),
              ],
            ),
        ],
      ),
    ),
  );
}

double getvalue(int index, int Id, List heartdata) {
  if (Id == 1) {
    return heartdata[index].restingHeartRate.toDouble();
  }
  if (Id == 2) {
    return heartdata[index].caloriesFatBurn;
  }
  if (Id == 3) {
    return heartdata[index].caloriesPeak;
  }
  if (Id == 4) {
    return heartdata[index].caloriesCardio;
  }
  return 0;
}

//);
//}
Widget bottomTitles(double value, TitleMeta meta) {
  List<String> titles = [
    DateFormat('EEEE')
        .format(DateTime.now().subtract(const Duration(days: 6)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(const Duration(days: 5)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(const Duration(days: 4)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(const Duration(days: 3)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(const Duration(days: 2)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(const Duration(days: 1)))
        .substring(0, 2),
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
    space: 16, //margin top
    child: text,
  );
}
