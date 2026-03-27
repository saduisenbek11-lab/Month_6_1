// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tittleMeta = const VerificationMeta('tittle');
  @override
  late final GeneratedColumn<String> tittle = GeneratedColumn<String>(
    'tittle',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 30,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tittle, isDone, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Todo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tittle')) {
      context.handle(
        _tittleMeta,
        tittle.isAcceptableOrUnknown(data['tittle']!, _tittleMeta),
      );
    } else if (isInserting) {
      context.missing(_tittleMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tittle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tittle'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String tittle;
  final bool isDone;
  final String date;
  const Todo({
    required this.id,
    required this.tittle,
    required this.isDone,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tittle'] = Variable<String>(tittle);
    map['is_done'] = Variable<bool>(isDone);
    map['date'] = Variable<String>(date);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      tittle: Value(tittle),
      isDone: Value(isDone),
      date: Value(date),
    );
  }

  factory Todo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      tittle: serializer.fromJson<String>(json['tittle']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tittle': serializer.toJson<String>(tittle),
      'isDone': serializer.toJson<bool>(isDone),
      'date': serializer.toJson<String>(date),
    };
  }

  Todo copyWith({int? id, String? tittle, bool? isDone, String? date}) => Todo(
    id: id ?? this.id,
    tittle: tittle ?? this.tittle,
    isDone: isDone ?? this.isDone,
    date: date ?? this.date,
  );
  Todo copyWithCompanion(TodosCompanion data) {
    return Todo(
      id: data.id.present ? data.id.value : this.id,
      tittle: data.tittle.present ? data.tittle.value : this.tittle,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('tittle: $tittle, ')
          ..write('isDone: $isDone, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tittle, isDone, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.tittle == this.tittle &&
          other.isDone == this.isDone &&
          other.date == this.date);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> tittle;
  final Value<bool> isDone;
  final Value<String> date;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.tittle = const Value.absent(),
    this.isDone = const Value.absent(),
    this.date = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String tittle,
    this.isDone = const Value.absent(),
    required String date,
  }) : tittle = Value(tittle),
       date = Value(date);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? tittle,
    Expression<bool>? isDone,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tittle != null) 'tittle': tittle,
      if (isDone != null) 'is_done': isDone,
      if (date != null) 'date': date,
    });
  }

  TodosCompanion copyWith({
    Value<int>? id,
    Value<String>? tittle,
    Value<bool>? isDone,
    Value<String>? date,
  }) {
    return TodosCompanion(
      id: id ?? this.id,
      tittle: tittle ?? this.tittle,
      isDone: isDone ?? this.isDone,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tittle.present) {
      map['tittle'] = Variable<String>(tittle.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('tittle: $tittle, ')
          ..write('isDone: $isDone, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}

typedef $$TodosTableCreateCompanionBuilder =
    TodosCompanion Function({
      Value<int> id,
      required String tittle,
      Value<bool> isDone,
      required String date,
    });
typedef $$TodosTableUpdateCompanionBuilder =
    TodosCompanion Function({
      Value<int> id,
      Value<String> tittle,
      Value<bool> isDone,
      Value<String> date,
    });

class $$TodosTableFilterComposer extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tittle => $composableBuilder(
    column: $table.tittle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TodosTableOrderingComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tittle => $composableBuilder(
    column: $table.tittle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TodosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TodosTable> {
  $$TodosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tittle =>
      $composableBuilder(column: $table.tittle, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$TodosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TodosTable,
          Todo,
          $$TodosTableFilterComposer,
          $$TodosTableOrderingComposer,
          $$TodosTableAnnotationComposer,
          $$TodosTableCreateCompanionBuilder,
          $$TodosTableUpdateCompanionBuilder,
          (Todo, BaseReferences<_$AppDatabase, $TodosTable, Todo>),
          Todo,
          PrefetchHooks Function()
        > {
  $$TodosTableTableManager(_$AppDatabase db, $TodosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tittle = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) => TodosCompanion(
                id: id,
                tittle: tittle,
                isDone: isDone,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tittle,
                Value<bool> isDone = const Value.absent(),
                required String date,
              }) => TodosCompanion.insert(
                id: id,
                tittle: tittle,
                isDone: isDone,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TodosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TodosTable,
      Todo,
      $$TodosTableFilterComposer,
      $$TodosTableOrderingComposer,
      $$TodosTableAnnotationComposer,
      $$TodosTableCreateCompanionBuilder,
      $$TodosTableUpdateCompanionBuilder,
      (Todo, BaseReferences<_$AppDatabase, $TodosTable, Todo>),
      Todo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TodosTableTableManager get todos =>
      $$TodosTableTableManager(_db, _db.todos);
}
