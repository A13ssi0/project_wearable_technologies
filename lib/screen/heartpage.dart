import 'package:fitbitter/fitbitter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/manageFitBitData.dart';
import '../utils/strings.dart';

class HeartPage extends StatefulWidget {
  //const HeartPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'heart';

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  var heartdata = [];
  @override
  void initState() {
    super.initState();
    loading();
  }

  Future<void> loading() async {
    var data = await fetchHeartDataSettimana();
    if (heartdata.isEmpty) {
      setState(() {
        heartdata = data;
      });
    }
  }

  double getvalue(int index, int Id) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HeartPage.routename),
      ),
      body: Container(
        child: Column(
          children: [
            (heartdata.isEmpty)
                ? Container()
                : Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 8, 0),
                    width: 400,
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
                                  toY: getvalue(i, 2),
                                  color: Colors.pinkAccent,
                                ),
                                BarChartRodData(
                                  toY: getvalue(i, 3),
                                  color: Colors.lightBlueAccent,
                                ),
                                BarChartRodData(
                                    toY: getvalue(i, 4),
                                    color: Colors.deepOrangeAccent),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
            Container(
                margin: EdgeInsets.fromLTRB(12, 12, 0, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: Text(''),
                              color: Colors.pinkAccent,
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0)),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              child: Text('caloriesFatBurn'),
                              padding: EdgeInsets.fromLTRB(6, 2, 0, 2)),
                          flex: 10,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: Text(''),
                              color: Colors.lightBlueAccent,
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0)),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              child: Text('caloriesPeak'),
                              padding: EdgeInsets.fromLTRB(6, 2, 0, 2)),
                          flex: 10,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: Text(''),
                              color: Colors.deepOrangeAccent,
                              padding: EdgeInsets.fromLTRB(6, 0, 0, 0)),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              child: Text('caloriesCardio'),
                              padding: EdgeInsets.fromLTRB(6, 2, 0, 2)),
                          flex: 10,
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cached),
          onPressed: () {
            setState(() {
              heartdata = [];
            });
            loading();
          }),
    );
  }
} //Page

//);
//}
Widget bottomTitles(double value, TitleMeta meta) {
  List<String> titles = [
    DateFormat('EEEE')
        .format(DateTime.now().subtract(Duration(days: 6)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(Duration(days: 5)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(Duration(days: 4)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(Duration(days: 3)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(Duration(days: 2)))
        .substring(0, 2),
    DateFormat('EEEE')
        .format(DateTime.now().subtract(Duration(days: 1)))
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
