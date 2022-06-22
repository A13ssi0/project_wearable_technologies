import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/daycare.dart';

@dao
abstract class DaycareDao {

  @Query('SELECT id FROM Todo')
  Future<List<int>?> findAllPkmn();

  @insert
  Future<void> addPkmn(Daycare pkmn);

  @delete
  Future<void> removePkmn(Daycare pkmn);

}