// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/palette.dart';

import 'package:project_wearable_technologies/utils/textSleep.dart';

class ButtonRowBar extends StatefulWidget {
  final double height;
  final double width;
  final Function() notifyParent;

  const ButtonRowBar({
    Key? key,
    required this.height,
    required this.width,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<ButtonRowBar> createState() => _ButtonRowBarState();
}

class _ButtonRowBarState extends State<ButtonRowBar> {
  static final List<bool> _isSelected = [false, false, false];
  final Color _retroColor = Palette.color3;
  final Color _backSelectColor = Colors.white;

  @override
  Widget build(BuildContext context) {
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
                            color: _choosenColor(idxButton: 0),
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), topLeft: Radius.circular(12))),
                        child: Text("Daily",
                            style: TextStyle(
                              color: _choosenColor(idxButton: 0, isText: true),
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
                          color: _choosenColor(idxButton: 1),
                        ),
                        child: Text("Weekly",
                            style: TextStyle(
                              color: _choosenColor(idxButton: 1, isText: true),
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
                            color: _choosenColor(idxButton: 2),
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12))),
                        child: Text("Monthly",
                            style: TextStyle(
                              color: _choosenColor(idxButton: 2, isText: true),
                              fontSize: _heightText,
                            )),
                      ))),
            ],
          )),
    );
  }

  Color _choosenColor({required int idxButton, bool isText = false}) {
    return isText
        ? _isSelected[idxButton]
            ? _retroColor
            : _backSelectColor
        : _isSelected[idxButton]
            ? _backSelectColor
            : _retroColor;
  }

  void _changeSelected(int nextSelect) {
    setState(() {
      TextSleep.positionButtonBar >= 0 ? _isSelected[TextSleep.positionButtonBar] = false : null;
      _isSelected[nextSelect] = true;
      TextSleep.positionButtonBar = nextSelect;
       widget.notifyParent();
    });
  }
}
