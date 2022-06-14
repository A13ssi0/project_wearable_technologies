import 'dart:async';
import 'package:flutter/material.dart';

class ClockTimer extends ChangeNotifier{

  int num = 0;

  void startTimer() {
    Timer.periodic(
      const Duration(minutes: 5),
      (Timer t) {
        num += 1;
        notifyListeners();
      },
    );
  }

}
