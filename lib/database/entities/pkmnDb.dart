import 'package:floor/floor.dart';

import 'activityData.dart';

@Entity(primaryKeys: [
  'id',
  'entry'
], foreignKeys: [
  ForeignKey(childColumns: ['idUpdate'], parentColumns: ['id'], entity: ActivityData)
])
class PkmnDb {
  final int id;
  final int expToLevelUp;
  int entry, exp, value;
  final int level = 1;
  final int? idEvol, lvEvol;
  final String sprite;
  final String name;
  bool isShop;
  final String type1;
  final String type2;

  @ColumnInfo(name: 'idUpdate')
  final int idUpdate;

  PkmnDb( 
      {required this.id,
      this.entry = 0,
      this.idEvol,
      this.lvEvol,
      required this.idUpdate,
      required this.expToLevelUp,
      required this.sprite,
      required this.name,
      this.value = 0,
      this.exp = 0,
      this.isShop = false,
      required this.type1,
      required this.type2, });
}
