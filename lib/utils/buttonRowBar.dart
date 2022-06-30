import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/textCalories.dart';

import 'package:project_wearable_technologies/utils/textSleep.dart';

class ButtonRowBar extends StatefulWidget {
  final double height;
  final double width;
  final Color color;
  String text;
  final Function() notifyParent;

  ButtonRowBar({
    Key? key,
    required this.height,
    required this.width,
    required this.notifyParent,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  State<ButtonRowBar> createState() => ButtonRowBarState();
}

class ButtonRowBarState extends State<ButtonRowBar> {
  static List<bool> isSelected = [false, false, false];
  final Color _backSelectColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final Color _retroColor = widget.color;
    final double _totalHeight = widget.height;
    final double _totalWidth = widget.width;
    double _heightText = _totalHeight * 0.5;
    return Container(
      alignment: Alignment.topCenter,
      child: Container(
          height: _totalHeight,
          width: _totalWidth,
          padding: const EdgeInsets.all(3.5),
          decoration: BoxDecoration(
            color: _retroColor,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: InkWell(
                      onTap: () => _changeSelected(0),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _choosenColor(_retroColor, idxButton: 0),
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12))),
                        child: Text("Daily",
                            style: TextStyle(
                              color: _choosenColor(_retroColor, idxButton: 0, isText: true),
                              fontSize: _heightText,
                            )),
                      ))),
              Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Container(color: _backSelectColor, width: 2)),
              Expanded(
                  child: InkWell(
                      onTap: () => _changeSelected(1),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _choosenColor(_retroColor, idxButton: 1),
                        ),
                        child: Text("Weekly",
                            style: TextStyle(
                              color: _choosenColor(_retroColor, idxButton: 1, isText: true),
                              fontSize: _heightText,
                            )),
                      ))),
              Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Container(color: _backSelectColor, width: 2)),
              Expanded(
                  child: InkWell(
                      onTap: () => _changeSelected(2),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: _choosenColor(_retroColor, idxButton: 2),
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12))),
                        child: Text("Monthly",
                            style: TextStyle(
                              color: _choosenColor(_retroColor, idxButton: 2, isText: true),
                              fontSize: _heightText,
                            )),
                      ))),
            ],
          )),
    );
  }

  Color _choosenColor(Color _retroColor, {required int idxButton, bool isText = false}) {
    return isText
        ? isSelected[idxButton]
            ? _retroColor
            : _backSelectColor
        : isSelected[idxButton]
            ? _backSelectColor
            : _retroColor;
  }

  void _changeSelected(int nextSelect) {
    setState(() {
      if (widget.text == 'sleep') {
        TextSleep.positionButtonBar >= 0 ? isSelected[TextSleep.positionButtonBar] = false : null;
        isSelected[nextSelect] = true;
        TextSleep.positionButtonBar = nextSelect;
        widget.notifyParent();
      } else if (widget.text == 'calories') {
        TextCalories.positionButtonBar >= 0 ? isSelected[TextCalories.positionButtonBar] = false : null;
        isSelected[nextSelect] = true;
        TextCalories.positionButtonBar = nextSelect;
        widget.notifyParent();
      }
    });
  }
}
