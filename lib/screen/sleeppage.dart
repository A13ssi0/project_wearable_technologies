import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/textSleep.dart';

import '../utils/plotSleep.dart';

class Sleeppage extends StatelessWidget {
  const Sleeppage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'sleep';

  @override
  Widget build(BuildContext context) {
    double _widthButtonBar = MediaQuery.of(context).size.width * 0.75;
    double _heightBar = 25;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              plotSleep(context),
              const SizedBox(
                height: 23,
              ),
              TextSleep(context, heightBar: _heightBar, widthBar: _widthButtonBar)
            ],
          ),]
        ),
      ),
    );
  }

  Widget title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          children: const [
            SizedBox(
              width: 30,
            ),
            Text('Sleep', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Colors.blue, fontFamily: 'Lobster')),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
      ],
    );
  }
}
