import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/activityData.dart';

@Entity(
  primaryKeys: ['id', 'entry'],
  foreignKeys: [
    ForeignKey(childColumns: ['idUpdate'], parentColumns: ['id'], entity: ActivityData)
  ])
class Daycare {
  final int id, expToEvolve; 
  final int entry, value = 0;
  final int level = 1;
  final int? idEvol, lvEvol;
  final String sprite;

  @ColumnInfo(name: 'idUpdate')
  final int idUpdate;

  Daycare(this.id, this.entry, this.idEvol, this.lvEvol, this.idUpdate, this.expToEvolve, this.sprite);
}

