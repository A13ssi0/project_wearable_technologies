import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/steps.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepsDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT * FROM Steps')
  Future<List<Steps>> findAllUpdates();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> insertUpdate(Steps update);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @Query('DELETE * FROM Steps')
  Future<void> clearSteps();

}