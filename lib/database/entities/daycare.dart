import 'package:floor/floor.dart';
import 'package:project_wearable_technologies/database/entities/steps.dart';

@Entity(
  primaryKeys: ['id', 'entry'],
  foreignKeys: [
    ForeignKey(childColumns: ['idUpdate'], parentColumns: ['id'], entity: Steps)
  ])
class Daycare {
  final int id, expToEvolve; 
  final int entry, value = 0;
  final int level = 1;
  final int? idEvol, lvEvol;

  @ColumnInfo(name: 'idUpdate')
  final int idUpdate;

  Daycare(this.id, this.entry, this.idEvol, this.lvEvol, this.idUpdate, this.expToEvolve);
}

