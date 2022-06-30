import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/pkmnDb.dart';

@dao
abstract class PkmnDao {
  @Query('SELECT * FROM PkmnDb')
  Future<List<PkmnDb>?> findAllPkmn();

  @Query('SELECT * FROM PkmnDb WHERE isShop = True')
  Future<List<PkmnDb>?> findPkmnShop();

  @Query('SELECT * FROM PkmnDb WHERE isShop = False')
  Future<List<PkmnDb>?> findPkmnDayCare();

  @insert
  Future<void> addPkmn(PkmnDb pkmn);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePkmn(PkmnDb pkmn);

  @delete
  Future<void> removePkmn(PkmnDb pkmn);

  @delete
  Future<void> removeListPkmn(List<PkmnDb> pkmn);

  @Query('DELETE FROM PkmnDb')
  Future<void> removeAllPkmn();

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> removePkmnFromShop(PkmnDb pkmn);
}
