import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/utils/buttonRowBar.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';
import 'package:project_wearable_technologies/utils/palette.dart';

class TextSleep extends StatefulWidget {
  final double heightBar;
  final double widthBar;
  static int positionButtonBar = -1;

  const TextSleep(BuildContext context, {Key? key, required this.heightBar, required this.widthBar}) : super(key: key);

  @override
  State<TextSleep> createState() => _TextSleepState();
}

class _TextSleepState extends State<TextSleep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ButtonRowBar(text: 'sleep', color: Palette.color3, height: widget.heightBar, width: widget.widthBar, notifyParent: refresh),
        const SizedBox(
          height: 15,
        ),
        TextSleep.positionButtonBar == -1
            ? const SizedBox()
            : SizedBox(
                child: constructTextSleep(),
                width: widget.widthBar,
              ),
      ],
    );
  }

  refresh() {
    setState(() {});
  }

  DateTime getDateFrom(DateTime today) {
    return TextSleep.positionButtonBar == 0
        ? today.subtract(const Duration(days: 1))
        : TextSleep.positionButtonBar == 1
            ? today.subtract(const Duration(days: 7))
            : DateTime(today.year, today.month - 1, today.day);
  }

  Widget constructTextSleep() {
    DateTime today = DateTime.now();
    DateTime pastDay = getDateFrom(today);
    String firstLine = 'Data acquired from ' + DateFormat('dd MMMM').format(pastDay) + ' to ' + DateFormat('dd MMMM').format(today) + '\n';
    return Center(
      child: Column(
        children: [
          Text(firstLine),
          evaluateDataSleep(from: pastDay, to: today),
        ],
      ),
    );
  }

  Widget evaluateDataSleep({required DateTime from, required DateTime to}) {
    return TextSleep.positionButtonBar == 1
        ? TimeSeriesSleep.week.isEmpty
            ? FutureBuilder(
                future: fetchSleepDataWeekly(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<SleepPoint> sleepData = extractSleepInfo(snapshot.data as List<FitbitSleepData>);
                    List<SleepPoint> cleanedSleepData = cleanSleepData(sleepData);
                    TimeSeriesSleep.week = cleanedSleepData;
                    return calculateDataSleep(data: TimeSeriesSleep.week);
                  } else {
                    return const SizedBox(
                      height: 60.0,
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/jigglypuff.gif',
                          ),
                          radius: 40,
                        ),
                      ),
                    );
                  }
                })
            : calculateDataSleep(data: TimeSeriesSleep.week)
        : TextSleep.positionButtonBar == 2
            ? TimeSeriesSleep.month.isEmpty
                ? FutureBuilder(
                    future: fetchSleepDataMonthly(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SleepPoint> sleepData = extractSleepInfo(snapshot.data as List<FitbitSleepData>);
                        List<SleepPoint> cleanedSleepData = cleanSleepData(sleepData);
                        TimeSeriesSleep.month = cleanedSleepData;
                        return calculateDataSleep(data: TimeSeriesSleep.month);
                      } else {
                        return const SizedBox(
                          height: 60.0,
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/jigglypuff.gif',
                              ),
                              radius: 40,
                            ),
                          ),
                        );
                      }
                    })
                : calculateDataSleep(data: TimeSeriesSleep.month)
            : calculateDataSleep(data: TimeSeriesSleep.yesterday);
  }

  Widget calculateDataSleep({required List<SleepPoint> data}) {
    List<int> time = [0, 0, 0, 0];

    for (int i = 0; i < data.length - 1; i++) {
      SleepPoint from = data[i];
      SleepPoint to = data[i + 1];
      if (from.time.difference(to.time).inHours.abs() < 24) {
        from.level >= 0 ? time[from.level] = time[from.level] + secondsBetween(from.time, to.time) : null;
      }
    }
    String doMean = '';
    if (TextSleep.positionButtonBar > 0) {
      doMean = ' mean';
    }
    String toDispLevel = 'Total' + doMean + ' time: \n';
    int totalSeconds = time.reduce((a, b) => a + b) ~/ TimeSeriesSleep.differenceDays[TextSleep.positionButtonBar];
    List<int> levelTime = fromSecondsToHoursMin(totalSeconds);
    int hours = levelTime[0];
    int minutes = levelTime[1];
    String toDispTime = hours.toString() + 'h  ' + minutes.toString() + 'min' '\n';

    for (int i = 0; i < time.length; i++) {
      time[i] = time[i] ~/ TimeSeriesSleep.differenceDays[TextSleep.positionButtonBar];

      List<int> levelTime = fromSecondsToHoursMin(time[i]);
      int hours = levelTime[0];
      int minutes = levelTime[1];
      String typeOfSleep = SleepPoint.sleepLevels[i][0].toUpperCase() + SleepPoint.sleepLevels[i].substring(1);
      toDispLevel = toDispLevel + typeOfSleep + doMean + ' time: \n';
      hours > 0 ? toDispTime = toDispTime + hours.toString() + 'h  ' : null;
      toDispTime = toDispTime + minutes.toString() + 'min' '\n';
    }

    Widget text1 = Text(
      toDispLevel,
      style: const TextStyle(fontSize: 18),
    );
    Widget text2 = Text(toDispTime, style: const TextStyle(fontSize: 18), textAlign: TextAlign.right);

    return Row(children: [
      text1,
      const Expanded(
        child: SizedBox(),
      ),
      text2
    ]);
  }

  int secondsBetween(DateTime from, DateTime to) {
    return (to.difference(from).inSeconds.abs());
  }

  List<int> fromSecondsToHoursMin(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds - hours * 3600) ~/ 60;
    return [hours, minutes];
  }
}
