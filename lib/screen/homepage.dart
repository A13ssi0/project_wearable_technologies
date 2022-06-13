import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/screen/steppage.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'NavBar.dart';
import 'heartpage.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(Homepage.routename),
      ),
      drawer: const NavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HeartPage.routename);
              },
              child: const Card(
                elevation: 10,
                //child: Padding(
                  //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child:  Text(
                    'Heart',
                    style: TextStyle(fontSize: 20),
                  ),
               // ),
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
            SizedBox(
              child: _plotSleep(context),
              height: 300,
            ),
          ],
        ),
      ),
    );
  } //build

  Widget _plotSleep(BuildContext context) {
    return FutureBuilder(
        future: fetchSleepDataYesterday(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SleepPoint> sleepData = extractSleepInfo(
                context, snapshot.data as List<FitbitSleepData>);
            List<SleepPoint> cleanedSleepData =
                cleanSleepData(context, sleepData);
            return SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('Hm'),
                axisLine: const AxisLine(width: 0),
                labelRotation: -90,
                interval: 0.5,
                minimum: SleepPoint.timeMin,
                maximum: SleepPoint.timeMax,
              ),
              primaryYAxis: NumericAxis(
                isVisible: true,
                interval: 1,
                majorGridLines: const MajorGridLines(width: 0.15),
                minimum: 0,
                maximum: SleepPoint.sleepLevels.length.toDouble() - 1,
                axisLabelFormatter: (AxisLabelRenderDetails args) {
                  late String? text =
                      SleepPoint.sleepLevels[int.parse(args.text)];
                  late TextStyle textStyle = args.textStyle;
                  return ChartAxisLabel(text!, textStyle);
                },
              ),
              series: <ChartSeries>[
                StepLineSeries<SleepPoint, DateTime>(
                  dataSource: cleanedSleepData,
                  xValueMapper: (SleepPoint data, _) => data.time,
                  yValueMapper: (SleepPoint data, _) => data.level,
                )
              ],
            );
          } else {
            return const SizedBox(
              height: 60.0,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
} //Page
