import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'homepage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Homepage.routename),
      ),
      drawer: const Text('data'),
      body: Center(
        child: SizedBox(
          child: _plotSleep(context),
          height: 300,
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
              // Initialize category axis
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('Hm'),
                axisLine: const AxisLine( width: 0),
                labelRotation: -90,
                interval: 0.5,
              ),
              primaryYAxis: NumericAxis(
                isVisible: true,
                interval: 1,
                majorGridLines: const MajorGridLines(width: 0.15), 
              minimum: 0,
                maximum: 3,
               axisLabelFormatter: (AxisLabelRenderDetails args) {
                  late String? text = cleanedSleepData[0].sleepLevels[int.parse(args.text)];
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
            return const CircularProgressIndicator();
          }
        });
  }
} //Page
