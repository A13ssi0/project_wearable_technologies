import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/activityData.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class ActivityDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM ActivityData')
  Future<List<ActivityData>?> findAllUpdates();

  @Query('SELECT COUNT(*) FROM ActivityData')
  Future<int?> countRow();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertUpdate(ActivityData update);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @Query('DELETE * FROM ActivityData')
  Future<void> clearSteps();

}