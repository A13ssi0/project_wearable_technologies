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

  StepsDao? _stepsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Daycare` (`id` INTEGER NOT NULL, `expToEvolve` INTEGER NOT NULL, `entry` INTEGER NOT NULL, `value` INTEGER NOT NULL, `level` INTEGER NOT NULL, `idEvol` INTEGER, `lvEvol` INTEGER, `idUpdate` INTEGER NOT NULL, FOREIGN KEY (`idUpdate`) REFERENCES `Steps` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`, `entry`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Steps` (`id` INTEGER NOT NULL, `steps` INTEGER NOT NULL, PRIMARY KEY (`id`))');

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
  StepsDao get stepsDao {
    return _stepsDaoInstance ??= _$StepsDao(database, changeListener);
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

class _$StepsDao extends StepsDao {
  _$StepsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _stepsInsertionAdapter = InsertionAdapter(
            database,
            'Steps',
            (Steps item) =>
                <String, Object?>{'id': item.id, 'steps': item.steps});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Steps> _stepsInsertionAdapter;

  @override
  Future<List<Steps>?> findAllUpdates() async {
    return _queryAdapter.queryList('SELECT * FROM Steps',
        mapper: (Map<String, Object?> row) =>
            Steps(row['id'] as int, row['steps'] as int));
  }

  @override
  Future<void> clearSteps() async {
    await _queryAdapter.queryNoReturn('DELETE * FROM Steps');
  }

  @override
  Future<void> insertUpdate(Steps update) async {
    await _stepsInsertionAdapter.insert(update, OnConflictStrategy.abort);
  }
}
