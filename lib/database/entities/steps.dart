import 'package:floor/floor.dart';

@entity
class Steps {

  @PrimaryKey(autoGenerate: false)
  final int id;

  final int steps;

  Steps(this.id, this.steps);
}