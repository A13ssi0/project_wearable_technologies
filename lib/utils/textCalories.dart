import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/buttonRowBar.dart';
import 'package:project_wearable_technologies/utils/palette.dart';

class TextCalories extends StatefulWidget {
  final double heightBar;
  final double widthBar;
  static int positionButtonBar = -1;
  final List<dynamic> heartdata;
  final List<dynamic> heartdatamonth;

  const TextCalories(BuildContext context, {Key? key, required this.heartdata, required this.heartdatamonth, required this.heightBar, required this.widthBar}) : super(key: key);

  @override
  State<TextCalories> createState() => _TextCaloriesState();
}

class _TextCaloriesState extends State<TextCalories> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> heartdata = widget.heartdata;
    List<dynamic> heartdatamonth = widget.heartdatamonth;
    return Column(
      children: [
        ButtonRowBar(text : 'calories',color: Palette.color4, height: widget.heightBar, width: widget.widthBar, notifyParent: refresh),
        const SizedBox(
          height: 15,
        ),
        TextCalories.positionButtonBar == -1
            ? const SizedBox()
            : SizedBox(
                child: constructTextCalories(heartdata, heartdatamonth),
                width: widget.widthBar,
              ),
      ],
    );
  }

  refresh() {
    setState(() {});
  }

  Widget constructTextCalories(List<dynamic> heartdata, List<dynamic> heartdatamonth) {
    return Center(
      child: Column(
        children: [
          evaluateDataCalories(heartdata, heartdatamonth),
        ],
      ),
    );
  }

  Widget evaluateDataCalories(List<dynamic> heartdata, List<dynamic> heartdatamonth){

    List<String> calories = ['', '', ''];

    if (TextCalories.positionButtonBar == 0){
      calories[0] = heartdata.last.caloriesOutOfRange.toStringAsFixed(0);
      calories[1] = heartdata.last.caloriesFatBurn.toStringAsFixed(0);
      calories[2] = heartdata.last.caloriesCardio.toStringAsFixed(0);
    }
    else if( TextCalories.positionButtonBar == 1){
      calories[0] = meanweekOut(heartdata);
      calories[1] = meanweekFat(heartdata);
      calories[2] = meanweekCardio(heartdata);
    }else{
      calories[0] = meanmonthOut(heartdatamonth);
      calories[1] = meanmonthFat(heartdatamonth);
      calories[2] = meanmonthCardio(heartdatamonth);
    }

    String doMean = '';
    if (TextCalories.positionButtonBar > 0) {
      doMean = ' mean';
    }

    String toDispLevel = 
    'Out of range'+doMean+' calories: \n'+
    'Fat burn'+doMean+' calories: \n'+
    'Cardio'+doMean+' calories: \n' ;

    String toDispCalories = calories[0] + ' kCal \n' + calories[1] + ' kCal \n' + calories[2] + ' kCal \n';


    Widget text1 = Text(
      toDispLevel,
      style: const TextStyle(fontSize: 18),
    );
    Widget text2 = Text(toDispCalories, style: const TextStyle(fontSize: 18), textAlign: TextAlign.right);

    return Row(children: [
      text1,
      const Expanded(
        child: SizedBox(),
      ),
      text2
    ]);

  }

  String meanweekFat(List<dynamic> heartdata) {
    double somma = 0;
    for (var i = 0; i < heartdata.length; i++) {
      if (heartdata[i].caloriesFatBurn != null) {
        somma = somma + heartdata[i].caloriesFatBurn;
      }
    }
    return (somma / heartdata.length).toStringAsFixed(0);
  }

  String meanweekOut(List<dynamic> heartdata) {
    double somma = 0;
    for (var i = 0; i < heartdata.length; i++) {
      if (heartdata[i].caloriesOutOfRange != null) {
        somma = somma + heartdata[i].caloriesOutOfRange;
      }
    }
    return (somma / heartdata.length).toStringAsFixed(0);
  }

  String meanweekCardio(List<dynamic> heartdata) {
    double somma = 0;
    for (var i = 0; i < heartdata.length; i++) {
      if (heartdata[i].caloriesCardio != null) {
        somma = somma + heartdata[i].caloriesCardio;
      }
    }
    return (somma / heartdata.length).toStringAsFixed(0);
  }

  String meanmonthCardio(List<dynamic> heartdatamonth) {
    double somma = 0;
    for (var i = 0; i < heartdatamonth.length; i++) {
      if (heartdatamonth[i].caloriesCardio != null) {
        somma = somma + heartdatamonth[i].caloriesCardio;
      }
    }
    return (somma / heartdatamonth.length).toStringAsFixed(0);
  }

  String meanmonthOut(List<dynamic> heartdatamonth) {
    double somma = 0;
    for (var i = 0; i < heartdatamonth.length; i++) {
      if (heartdatamonth[i].caloriesOutOfRange != null) {
        somma = somma + heartdatamonth[i].caloriesOutOfRange;
      }
    }
    return (somma / heartdatamonth.length).toStringAsFixed(0);
  }

  String meanmonthFat(List<dynamic> heartdatamonth) {
    double somma = 0;
    for (var i = 0; i < heartdatamonth.length; i++) {
      if (heartdatamonth[i].caloriesFatBurn != null) {
        somma = somma + heartdatamonth[i].caloriesFatBurn;
      }
    }
    return (somma / heartdatamonth.length).toStringAsFixed(0);
  }


  
}
