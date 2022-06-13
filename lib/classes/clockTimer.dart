import 'dart:async';
import 'package:flutter/material.dart';

class ClockTimer extends ChangeNotifier{

  void startTimer() {
    Timer.periodic(
      const Duration(minutes: 5),
      (Timer t) {
        notifyListeners();
      },
    );
  }

}
