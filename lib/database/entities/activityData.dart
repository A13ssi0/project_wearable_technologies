import 'package:floor/floor.dart';

@entity
class ActivityData {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int steps;
  final int calories;
  final int day; 
  final int month;
  final int year;
  
  ActivityData(this.id, this.steps, this.calories, this.day, this.month, this.year);
}