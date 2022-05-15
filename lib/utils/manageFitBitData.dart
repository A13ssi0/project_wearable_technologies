import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/strings.dart';

class SleepPoint {
  final DateTime? time;
  final List<String?> sleepLevels = ['rem', 'deep', 'light', 'wake'];
  int? level;
  SleepPoint(this.time, String? levelString) {
    level = sleepLevels.indexOf(levelString);
  }
}

Future<List<FitbitSleepData>> fetchSleepDataYesterday(
    BuildContext context) async {
  FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );
  FitbitSleepAPIURL fitbitSleepAPIURL = FitbitSleepAPIURL.withUserIDAndDay(
    date: DateTime.now().subtract(const Duration(days: 1)),
    userID: Strings.userId,
  );
  final data = await fitbitSleepDataManager.fetch(fitbitSleepAPIURL)
      as List<FitbitSleepData>;
  return data;
}

List<SleepPoint> extractSleepInfo(
    BuildContext context, List<FitbitSleepData> sleepData) {
  List<SleepPoint> sleepInfo = [];
  for (int i = 0; i < sleepData.length; i++) {
    i == 0 || sleepData[i].level != sleepData[i - 1].level
        ? sleepInfo
            .add(SleepPoint(sleepData[i].entryDateTime, sleepData[i].level))
        : null;
  }
  sleepInfo.add(SleepPoint(sleepData.last.entryDateTime?.add(const Duration(minutes: 10)), sleepData.last.level));
  return sleepInfo;
}

List<SleepPoint> cleanSleepData(
    BuildContext context, List<SleepPoint> sleepData) {
  for (int i = 0; i < sleepData.length-1; i++) {
    if (!sleepData[i+1]
        .time!
        .isAfter(sleepData[i].time!.add(const Duration(minutes: 3)))) {
      sleepData.remove(sleepData[i]);
      i--;
    }
  }
  return sleepData;
}
