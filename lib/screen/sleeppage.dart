import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/clockTimer.dart';

class Sleeppage extends StatefulWidget {
  const Sleeppage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'sleep';

  @override
  State<Sleeppage> createState() => _SleeppageState();
}

class _SleeppageState extends State<Sleeppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Sleeppage.routename),
      ),
      body: Center(
        child: Consumer<ClockTimer>(builder: (context, clock, child) {
              return Text(clock.num.toString());
            }),
      ),
    );
  } } //Page
