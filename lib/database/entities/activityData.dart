import 'package:floor/floor.dart';

@entity
class ActivityData {
  @PrimaryKey(autoGenerate: true)
  int? id;

  int steps;
  int calories;
  int day;
  int month;
  int year;

  ActivityData(this.id, this.steps, this.calories, this.day, this.month, this.year);
}
