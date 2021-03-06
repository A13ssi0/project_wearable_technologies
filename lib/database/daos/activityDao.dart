import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/activityData.dart';

@dao
abstract class ActivityDao {
  @Query('SELECT * FROM ActivityData')
  Future<List<ActivityData>?> findAllUpdates();

  @Query('SELECT * FROM ActivityData WHERE id = :id')
  Future<ActivityData?> findUpdateById(int id);

  @insert
  Future<int> insertUpdate(ActivityData update);

  @Query('DELETE FROM ActivityData')
  Future<void> clearActivity();
}
