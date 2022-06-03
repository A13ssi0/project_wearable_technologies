import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_wearable_technologies/screen/gamepage.dart';
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
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                  leading: const Icon(MdiIcons.pokeball),
                  title: const Text('To Pokemon'),
                  onTap: () {
                    Navigator.pushNamed(context, Gamepage.routename);
                  }),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Passi'),
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
            List<SleepPoint> sleepData = extractSleepInfo(context, snapshot.data as List<FitbitSleepData>);
            List<SleepPoint> cleanedSleepData = cleanSleepData(context, sleepData);
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
                  late String? text = SleepPoint.sleepLevels[int.parse(args.text)];
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
