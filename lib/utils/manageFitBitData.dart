import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/strings.dart';

Future<List<FitbitSleepData>> fetchSleepDataYesterday(BuildContext context) async {
    FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
      clientID: Strings.fitbitClientID,
      clientSecret: Strings.fitbitClientSecret,
    );
    FitbitSleepAPIURL fitbitSleepAPIURL = FitbitSleepAPIURL.withUserIDAndDay(
      date: DateTime.now().subtract(const Duration(days: 1)),
      userID: Strings.userId,
    );
    final data = await fitbitSleepDataManager.fetch(fitbitSleepAPIURL) as List<FitbitSleepData>;
    return data;
  }
  

Map<dynamic, String?> extractSleepInfo (BuildContext context, List<FitbitSleepData> sleepData){
  Map<dynamic, String?> sleepInfo = {};
  for (int i=0; i<sleepData.length; i++) {
    i==0 || sleepData[i].level != sleepData[i-1].level
    ? sleepInfo[sleepData[i].entryDateTime] = sleepData[i].level
    : null;
    }
  return sleepInfo;
}
