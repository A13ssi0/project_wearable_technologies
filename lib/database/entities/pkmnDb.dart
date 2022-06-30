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
  final String expToLevelUp;
  int entry, exp, value;
  int level;
  String? nameEvol; 
  int? lvEvol;
  final String sprite;
  String name;
  bool isShop;
  final String type1;
  final String type2;
  bool isBuyed;
  int totalExpAcquired;
  

  @ColumnInfo(name: 'idUpdate')
  int idUpdate;

  PkmnDb( 
      {required this.id,
      this.entry = 0,
      this.nameEvol,
      this.lvEvol,
      required this.idUpdate,
      required this.expToLevelUp,
      required this.sprite,
      required this.name,
      this.value = 0,
      this.exp = 0,
      this.level = 1,
      this.isBuyed = false,
      this.isShop = false,
      required this.type1,
      required this.type2,
      this.totalExpAcquired = 0, });
}
