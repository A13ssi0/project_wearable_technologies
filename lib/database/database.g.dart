// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PkmnDao? _pkmnDaoInstance;

  ActivityDao? _activityDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PkmnDb` (`id` INTEGER NOT NULL, `expToLevelUp` TEXT NOT NULL, `entry` INTEGER NOT NULL, `exp` INTEGER NOT NULL, `value` INTEGER NOT NULL, `level` INTEGER NOT NULL, `nameEvol` TEXT, `lvEvol` INTEGER, `sprite` TEXT NOT NULL, `name` TEXT NOT NULL, `isShop` INTEGER NOT NULL, `type1` TEXT NOT NULL, `type2` TEXT NOT NULL, `isBuyed` INTEGER NOT NULL, `totalExpAcquired` INTEGER NOT NULL, `idUpdate` INTEGER NOT NULL, FOREIGN KEY (`idUpdate`) REFERENCES `ActivityData` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`, `entry`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivityData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `steps` INTEGER NOT NULL, `calories` INTEGER NOT NULL, `day` INTEGER NOT NULL, `month` INTEGER NOT NULL, `year` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PkmnDao get pkmnDao {
    return _pkmnDaoInstance ??= _$PkmnDao(database, changeListener);
  }

  @override
  ActivityDao get activityDao {
    return _activityDaoInstance ??= _$ActivityDao(database, changeListener);
  }
}

class _$PkmnDao extends PkmnDao {
  _$PkmnDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _pkmnDbInsertionAdapter = InsertionAdapter(
            database,
            'PkmnDb',
            (PkmnDb item) => <String, Object?>{
                  'id': item.id,
                  'expToLevelUp': item.expToLevelUp,
                  'entry': item.entry,
                  'exp': item.exp,
                  'value': item.value,
                  'level': item.level,
                  'nameEvol': item.nameEvol,
                  'lvEvol': item.lvEvol,
                  'sprite': item.sprite,
                  'name': item.name,
                  'isShop': item.isShop ? 1 : 0,
                  'type1': item.type1,
                  'type2': item.type2,
                  'isBuyed': item.isBuyed ? 1 : 0,
                  'totalExpAcquired': item.totalExpAcquired,
                  'idUpdate': item.idUpdate
                }),
        _pkmnDbUpdateAdapter = UpdateAdapter(
            database,
            'PkmnDb',
            ['id', 'entry'],
            (PkmnDb item) => <String, Object?>{
                  'id': item.id,
                  'expToLevelUp': item.expToLevelUp,
                  'entry': item.entry,
                  'exp': item.exp,
                  'value': item.value,
                  'level': item.level,
                  'nameEvol': item.nameEvol,
                  'lvEvol': item.lvEvol,
                  'sprite': item.sprite,
                  'name': item.name,
                  'isShop': item.isShop ? 1 : 0,
                  'type1': item.type1,
                  'type2': item.type2,
                  'isBuyed': item.isBuyed ? 1 : 0,
                  'totalExpAcquired': item.totalExpAcquired,
                  'idUpdate': item.idUpdate
                }),
        _pkmnDbDeletionAdapter = DeletionAdapter(
            database,
            'PkmnDb',
            ['id', 'entry'],
            (PkmnDb item) => <String, Object?>{
                  'id': item.id,
                  'expToLevelUp': item.expToLevelUp,
                  'entry': item.entry,
                  'exp': item.exp,
                  'value': item.value,
                  'level': item.level,
                  'nameEvol': item.nameEvol,
                  'lvEvol': item.lvEvol,
                  'sprite': item.sprite,
                  'name': item.name,
                  'isShop': item.isShop ? 1 : 0,
                  'type1': item.type1,
                  'type2': item.type2,
                  'isBuyed': item.isBuyed ? 1 : 0,
                  'totalExpAcquired': item.totalExpAcquired,
                  'idUpdate': item.idUpdate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PkmnDb> _pkmnDbInsertionAdapter;

  final UpdateAdapter<PkmnDb> _pkmnDbUpdateAdapter;

  final DeletionAdapter<PkmnDb> _pkmnDbDeletionAdapter;

  @override
  Future<List<PkmnDb>?> findAllPkmn() async {
    return _queryAdapter.queryList('SELECT * FROM PkmnDb',
        mapper: (Map<String, Object?> row) => PkmnDb(
            id: row['id'] as int,
            entry: row['entry'] as int,
            nameEvol: row['nameEvol'] as String?,
            lvEvol: row['lvEvol'] as int?,
            idUpdate: row['idUpdate'] as int,
            expToLevelUp: row['expToLevelUp'] as String,
            sprite: row['sprite'] as String,
            name: row['name'] as String,
            value: row['value'] as int,
            exp: row['exp'] as int,
            level: row['level'] as int,
            isBuyed: (row['isBuyed'] as int) != 0,
            isShop: (row['isShop'] as int) != 0,
            type1: row['type1'] as String,
            type2: row['type2'] as String,
            totalExpAcquired: row['totalExpAcquired'] as int));
  }

  @override
  Future<List<PkmnDb>?> findPkmnShop() async {
    return _queryAdapter.queryList('SELECT * FROM PkmnDb WHERE isShop = True',
        mapper: (Map<String, Object?> row) => PkmnDb(
            id: row['id'] as int,
            entry: row['entry'] as int,
            nameEvol: row['nameEvol'] as String?,
            lvEvol: row['lvEvol'] as int?,
            idUpdate: row['idUpdate'] as int,
            expToLevelUp: row['expToLevelUp'] as String,
            sprite: row['sprite'] as String,
            name: row['name'] as String,
            value: row['value'] as int,
            exp: row['exp'] as int,
            level: row['level'] as int,
            isBuyed: (row['isBuyed'] as int) != 0,
            isShop: (row['isShop'] as int) != 0,
            type1: row['type1'] as String,
            type2: row['type2'] as String,
            totalExpAcquired: row['totalExpAcquired'] as int));
  }

  @override
  Future<List<PkmnDb>?> findPkmnDayCare() async {
    return _queryAdapter.queryList('SELECT * FROM PkmnDb WHERE isShop = False',
        mapper: (Map<String, Object?> row) => PkmnDb(
            id: row['id'] as int,
            entry: row['entry'] as int,
            nameEvol: row['nameEvol'] as String?,
            lvEvol: row['lvEvol'] as int?,
            idUpdate: row['idUpdate'] as int,
            expToLevelUp: row['expToLevelUp'] as String,
            sprite: row['sprite'] as String,
            name: row['name'] as String,
            value: row['value'] as int,
            exp: row['exp'] as int,
            level: row['level'] as int,
            isBuyed: (row['isBuyed'] as int) != 0,
            isShop: (row['isShop'] as int) != 0,
            type1: row['type1'] as String,
            type2: row['type2'] as String,
            totalExpAcquired: row['totalExpAcquired'] as int));
  }

  @override
  Future<void> removeAllPkmn() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PkmnDb');
  }

  @override
  Future<void> addPkmn(PkmnDb pkmn) async {
    await _pkmnDbInsertionAdapter.insert(pkmn, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePkmn(PkmnDb pkmn) async {
    await _pkmnDbUpdateAdapter.update(pkmn, OnConflictStrategy.replace);
  }

  @override
  Future<void> removePkmnFromShop(PkmnDb pkmn) async {
    await _pkmnDbUpdateAdapter.update(pkmn, OnConflictStrategy.replace);
  }

  @override
  Future<void> removePkmn(PkmnDb pkmn) async {
    await _pkmnDbDeletionAdapter.delete(pkmn);
  }

  @override
  Future<void> removeListPkmn(List<PkmnDb> pkmn) async {
    await _pkmnDbDeletionAdapter.deleteList(pkmn);
  }
}

class _$ActivityDao extends ActivityDao {
  _$ActivityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityDataInsertionAdapter = InsertionAdapter(
            database,
            'ActivityData',
            (ActivityData item) => <String, Object?>{
                  'id': item.id,
                  'steps': item.steps,
                  'calories': item.calories,
                  'day': item.day,
                  'month': item.month,
                  'year': item.year
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityData> _activityDataInsertionAdapter;

  @override
  Future<List<ActivityData>?> findAllUpdates() async {
    return _queryAdapter.queryList('SELECT * FROM ActivityData',
        mapper: (Map<String, Object?> row) => ActivityData(
            row['id'] as int?,
            row['steps'] as int,
            row['calories'] as int,
            row['day'] as int,
            row['month'] as int,
            row['year'] as int));
  }

  @override
  Future<ActivityData?> findUpdateById(int id) async {
    return _queryAdapter.query('SELECT * FROM ActivityData WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ActivityData(
            row['id'] as int?,
            row['steps'] as int,
            row['calories'] as int,
            row['day'] as int,
            row['month'] as int,
            row['year'] as int),
        arguments: [id]);
  }

  @override
  Future<void> clearActivity() async {
    await _queryAdapter.queryNoReturn('DELETE FROM ActivityData');
  }

  @override
  Future<int> insertUpdate(ActivityData update) {
    return _activityDataInsertionAdapter.insertAndReturnId(
        update, OnConflictStrategy.abort);
  }
}
