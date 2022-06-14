import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/daycare.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class DaycareDao {

  //Query #1: SELECT -> this allows to obtain all the entries of the Todo table
  @Query('SELECT id FROM Todo')
  Future<List<int>?> findAllPkmn();

  //Query #2: INSERT -> this allows to add a Todo in the table
  @insert
  Future<void> addPkmn(Daycare pkmn);

  //Query #3: DELETE -> this allows to delete a Todo from the table
  @delete
  Future<void> removePkmn(Daycare pkmn);

}