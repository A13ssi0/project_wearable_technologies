import 'package:floor/floor.dart';

@entity
class ActivityData {

  @PrimaryKey(autoGenerate: false)
  final int id;

  final int steps;
  final int calories;
  
  ActivityData(this.id, this.steps, this.calories);
}