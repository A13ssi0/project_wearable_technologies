import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/activityData.dart';

@dao
abstract class ActivityDao {

  @Query('SELECT * FROM ActivityData')
  Future<List<ActivityData>?> findAllUpdates();

  @Query('SELECT MAX(id) FROM ActivityData')
  Future<int?> idxLastUpdate();

  @insert
  Future<int> insertUpdate(ActivityData update);

  @Query('DELETE FROM ActivityData')
  Future<void> clearActivity();

}