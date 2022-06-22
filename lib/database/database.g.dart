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

  DaycareDao? _daycareDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Daycare` (`id` INTEGER NOT NULL, `expToEvolve` INTEGER NOT NULL, `entry` INTEGER NOT NULL, `value` INTEGER NOT NULL, `level` INTEGER NOT NULL, `idEvol` INTEGER, `lvEvol` INTEGER, `sprite` TEXT NOT NULL, `idUpdate` INTEGER NOT NULL, FOREIGN KEY (`idUpdate`) REFERENCES `ActivityData` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`, `entry`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivityData` (`id` INTEGER NOT NULL, `steps` INTEGER NOT NULL, `calories` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DaycareDao get daycareDao {
    return _daycareDaoInstance ??= _$DaycareDao(database, changeListener);
  }

  @override
  ActivityDao get activityDao {
    return _activityDaoInstance ??= _$ActivityDao(database, changeListener);
  }
}

class _$DaycareDao extends DaycareDao {
  _$DaycareDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _daycareInsertionAdapter = InsertionAdapter(
            database,
            'Daycare',
            (Daycare item) => <String, Object?>{
                  'id': item.id,
                  'expToEvolve': item.expToEvolve,
                  'entry': item.entry,
                  'value': item.value,
                  'level': item.level,
                  'idEvol': item.idEvol,
                  'lvEvol': item.lvEvol,
                  'sprite': item.sprite,
                  'idUpdate': item.idUpdate
                }),
        _daycareDeletionAdapter = DeletionAdapter(
            database,
            'Daycare',
            ['id', 'entry'],
            (Daycare item) => <String, Object?>{
                  'id': item.id,
                  'expToEvolve': item.expToEvolve,
                  'entry': item.entry,
                  'value': item.value,
                  'level': item.level,
                  'idEvol': item.idEvol,
                  'lvEvol': item.lvEvol,
                  'sprite': item.sprite,
                  'idUpdate': item.idUpdate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Daycare> _daycareInsertionAdapter;

  final DeletionAdapter<Daycare> _daycareDeletionAdapter;

  @override
  Future<List<int>?> findAllPkmn() async {
    await _queryAdapter.queryNoReturn('SELECT id FROM Todo');
  }

  @override
  Future<void> addPkmn(Daycare pkmn) async {
    await _daycareInsertionAdapter.insert(pkmn, OnConflictStrategy.abort);
  }

  @override
  Future<void> removePkmn(Daycare pkmn) async {
    await _daycareDeletionAdapter.delete(pkmn);
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
                  'calories': item.calories
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityData> _activityDataInsertionAdapter;

  @override
  Future<List<ActivityData>?> findAllUpdates() async {
    return _queryAdapter.queryList('SELECT * FROM ActivityData',
        mapper: (Map<String, Object?> row) => ActivityData(
            row['id'] as int, row['steps'] as int, row['calories'] as int));
  }

  @override
  Future<void> clearActivity() async {
    await _queryAdapter.queryNoReturn('DELETE * FROM ActivityData');
  }

  @override
  Future<int?> countRow() async {
    await _queryAdapter.queryNoReturn('SELECT MAX(id) FROM ActivityData');
  }

  @override
  Future<void> insertUpdate(ActivityData update) async {
    await _activityDataInsertionAdapter.insert(
        update, OnConflictStrategy.abort);
  }
}
