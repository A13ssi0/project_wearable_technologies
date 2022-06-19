import 'package:fitbitter/fitbitter.dart';
import 'package:project_wearable_technologies/utils/strings.dart';


// MANAGE SLEEP DATA ----------------------------------------------------------------------------------------
class SleepPoint {
  final DateTime time;
  static List<String> sleepLevels = ['deep', 'light', 'rem', 'wake'];
  static DateTime timeMin = DateTime.now();
  static DateTime timeMax = DateTime.now();
  late int level;
  SleepPoint(this.time, String levelString) {
    level = SleepPoint.sleepLevels.contains(levelString) ? sleepLevels.indexOf(levelString) : -1;
  }
}

class TimeSeriesSleep {
  static List<SleepPoint> yesterday = [];
  static List<SleepPoint> week = [];
  static List<SleepPoint> month = [];
  static List<int> differenceDays = [1,7,30];
}

Future<List<FitbitSleepData>> fetchSleepDataYesterday() async {
  FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );
  FitbitSleepAPIURL fitbitSleepAPIURL = FitbitSleepAPIURL.withUserIDAndDay(
    date: DateTime.now(),
    userID: Strings.userId,
  );
  final data = await fitbitSleepDataManager.fetch(fitbitSleepAPIURL) as List<FitbitSleepData>;
  SleepPoint.timeMin = data[0].entryDateTime as DateTime;
  SleepPoint.timeMax = data.last.entryDateTime?.add(const Duration(minutes: 10)) as DateTime;
  return data;
}

Future<List<FitbitSleepData>> fetchSleepDataWeekly() async {
  FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );
  FitbitSleepAPIURL fitbitSleepAPIURL = FitbitSleepAPIURL.withUserIDAndDateRange(
    startDate: DateTime.now().subtract(const Duration(days: 7)),
    endDate: DateTime.now(),
    userID: Strings.userId,
  );
  final data = await fitbitSleepDataManager.fetch(fitbitSleepAPIURL) as List<FitbitSleepData>;
  return data;
}

Future<List<FitbitSleepData>> fetchSleepDataMonthly() async {
  FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );
  DateTime startingDate = DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  FitbitSleepAPIURL fitbitSleepAPIURL = FitbitSleepAPIURL.withUserIDAndDateRange(
    startDate: startingDate,
    endDate: DateTime.now(),
    userID: Strings.userId,
  );
  TimeSeriesSleep.differenceDays[2] = DateTime.now().difference(startingDate).inDays.abs();
  final data = await fitbitSleepDataManager.fetch(fitbitSleepAPIURL) as List<FitbitSleepData>;
  return data;
}

List<SleepPoint> extractSleepInfo(List<FitbitSleepData> sleepData) {
  List<SleepPoint> sleepInfo = [];
  for (int i = 0; i < sleepData.length; i++) {
    i == 0 || sleepData[i].level != sleepData[i - 1].level ? sleepInfo.add(SleepPoint(sleepData[i].entryDateTime as DateTime, sleepData[i].level as String)) : null;
  }
  sleepInfo.add(SleepPoint(SleepPoint.timeMax, sleepData.last.level as String));
  return sleepInfo;
}

List<SleepPoint> cleanSleepData(List<SleepPoint> sleepData) {
  for (int i = 0; i < sleepData.length - 1; i++) {
    if (sleepData[i + 1].time.isBefore(sleepData[i].time.add(const Duration(minutes: 3)))) {
      sleepData.remove(sleepData[i]);
      i--;
    }
  }
  List<DateTime> dataTime = sleepData.map((e) => e.time).toList();
  List<DateTime> sortedDataTime = dataTime;
  sortedDataTime.sort((a,b) => a.compareTo(b));
  sleepData = sortedDataTime.map((e) => sleepData[dataTime.indexOf(e)]).toList();
  return sleepData;
}