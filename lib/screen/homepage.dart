import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';

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
        child: _plotSleep(context),
      ),
    );
  }//build

  Widget _plotSleep(BuildContext context){
    return FutureBuilder(
          future: fetchSleepDataYesterday(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, String?> sleepInfo = extractSleepInfo(context, snapshot.data as List<FitbitSleepData>);
              return const Text('Fetched data');
            } else {
              return const CircularProgressIndicator();
            }
          });
  }

} //Page
