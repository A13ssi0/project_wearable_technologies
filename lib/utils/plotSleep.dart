import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screen/sleeppage.dart';
import 'manageFitBitData.dart';

Widget plotSleep(BuildContext context) {
  return TimeSeriesSleep.yesterday.isNotEmpty
      ? chartSleep(context)
      : FutureBuilder(
          future: fetchSleepDataYesterday(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<SleepPoint> sleepData = extractSleepInfo(snapshot.data as List<FitbitSleepData>);
              List<SleepPoint> cleanedSleepData = cleanSleepData(sleepData);
              TimeSeriesSleep.yesterday = cleanedSleepData;
              return chartSleep(context);
            } else {
              return const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/jigglypuff.gif',
                  ),
                  radius: 100,
                ),
                // ),
              );
            }
          });
}

Widget chartSleep(BuildContext context) {
  bool isSleepPage = false;
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: false);
  DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
  String dayMonth = DateFormat('dd MMMM y').format(yesterday);

  Navigator.popUntil(context, (route) {
    if (route.settings.name == Sleeppage.routename) {
      isSleepPage = true;
      _tooltipBehavior = TooltipBehavior(enable: true);
    } else {
      isSleepPage = false;
      _tooltipBehavior = TooltipBehavior(enable: false);
    }
    return true;
  });

  return SfCartesianChart(
    onChartTouchInteractionUp: (ChartTouchInteractionArgs args) {
      if (!isSleepPage) {
        Navigator.pushNamed(context, Sleeppage.routename);
      }
    },
    title: ChartTitle(text: 'Sleep Levels of ' + dayMonth + ' nigth'),
    tooltipBehavior: _tooltipBehavior,
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
        return ChartAxisLabel(text, textStyle);
      },
    ),
    series: <ChartSeries>[
      StepLineSeries<SleepPoint, DateTime>(
        enableTooltip: isSleepPage,
        dataSource: TimeSeriesSleep.yesterday,
        xValueMapper: (SleepPoint data, _) => data.time,
        yValueMapper: (SleepPoint data, _) => data.level,
      )
    ],
  );
}
