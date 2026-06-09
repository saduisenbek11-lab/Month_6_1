// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ResultsTable extends Results with TableInfo<$ResultsTable, Result> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalQuestionsMeta = const VerificationMeta(
    'totalQuestions',
  );
  @override
  late final GeneratedColumn<int> totalQuestions = GeneratedColumn<int>(
    'total_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    difficulty,
    totalQuestions,
    correctAnswers,
    takenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'results';
  @override
  VerificationContext validateIntegrity(
    Insertable<Result> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('total_questions')) {
      context.handle(
        _totalQuestionsMeta,
        totalQuestions.isAcceptableOrUnknown(
          data['total_questions']!,
          _totalQuestionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalQuestionsMeta);
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctAnswersMeta);
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Result map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Result(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      ),
      totalQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_questions'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      )!,
    );
  }

  @override
  $ResultsTable createAlias(String alias) {
    return $ResultsTable(attachedDatabase, alias);
  }
}

class Result extends DataClass implements Insertable<Result> {
  final int id;
  final String category;
  final String? difficulty;
  final int totalQuestions;
  final int correctAnswers;
  final DateTime takenAt;
  const Result({
    required this.id,
    required this.category,
    this.difficulty,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.takenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || difficulty != null) {
      map['difficulty'] = Variable<String>(difficulty);
    }
    map['total_questions'] = Variable<int>(totalQuestions);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['taken_at'] = Variable<DateTime>(takenAt);
    return map;
  }

  ResultsCompanion toCompanion(bool nullToAbsent) {
    return ResultsCompanion(
      id: Value(id),
      category: Value(category),
      difficulty: difficulty == null && nullToAbsent
          ? const Value.absent()
          : Value(difficulty),
      totalQuestions: Value(totalQuestions),
      correctAnswers: Value(correctAnswers),
      takenAt: Value(takenAt),
    );
  }

  factory Result.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Result(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      difficulty: serializer.fromJson<String?>(json['difficulty']),
      totalQuestions: serializer.fromJson<int>(json['totalQuestions']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'difficulty': serializer.toJson<String?>(difficulty),
      'totalQuestions': serializer.toJson<int>(totalQuestions),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'takenAt': serializer.toJson<DateTime>(takenAt),
    };
  }

  Result copyWith({
    int? id,
    String? category,
    Value<String?> difficulty = const Value.absent(),
    int? totalQuestions,
    int? correctAnswers,
    DateTime? takenAt,
  }) => Result(
    id: id ?? this.id,
    category: category ?? this.category,
    difficulty: difficulty.present ? difficulty.value : this.difficulty,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    takenAt: takenAt ?? this.takenAt,
  );
  Result copyWithCompanion(ResultsCompanion data) {
    return Result(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      totalQuestions: data.totalQuestions.present
          ? data.totalQuestions.value
          : this.totalQuestions,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Result(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    difficulty,
    totalQuestions,
    correctAnswers,
    takenAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Result &&
          other.id == this.id &&
          other.category == this.category &&
          other.difficulty == this.difficulty &&
          other.totalQuestions == this.totalQuestions &&
          other.correctAnswers == this.correctAnswers &&
          other.takenAt == this.takenAt);
}

class ResultsCompanion extends UpdateCompanion<Result> {
  final Value<int> id;
  final Value<String> category;
  final Value<String?> difficulty;
  final Value<int> totalQuestions;
  final Value<int> correctAnswers;
  final Value<DateTime> takenAt;
  const ResultsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.totalQuestions = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.takenAt = const Value.absent(),
  });
  ResultsCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    this.difficulty = const Value.absent(),
    required int totalQuestions,
    required int correctAnswers,
    this.takenAt = const Value.absent(),
  }) : category = Value(category),
       totalQuestions = Value(totalQuestions),
       correctAnswers = Value(correctAnswers);
  static Insertable<Result> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? difficulty,
    Expression<int>? totalQuestions,
    Expression<int>? correctAnswers,
    Expression<DateTime>? takenAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (difficulty != null) 'difficulty': difficulty,
      if (totalQuestions != null) 'total_questions': totalQuestions,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (takenAt != null) 'taken_at': takenAt,
    });
  }

  ResultsCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<String?>? difficulty,
    Value<int>? totalQuestions,
    Value<int>? correctAnswers,
    Value<DateTime>? takenAt,
  }) {
    return ResultsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      takenAt: takenAt ?? this.takenAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (totalQuestions.present) {
      map['total_questions'] = Variable<int>(totalQuestions.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResultsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('difficulty: $difficulty, ')
          ..write('totalQuestions: $totalQuestions, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ResultsTable results = $ResultsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [results];
}

typedef $$ResultsTableCreateCompanionBuilder =
    ResultsCompanion Function({
      Value<int> id,
      required String category,
      Value<String?> difficulty,
      required int totalQuestions,
      required int correctAnswers,
      Value<DateTime> takenAt,
    });
typedef $$ResultsTableUpdateCompanionBuilder =
    ResultsCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<String?> difficulty,
      Value<int> totalQuestions,
      Value<int> correctAnswers,
      Value<DateTime> takenAt,
    });

class $$ResultsTableFilterComposer
    extends Composer<_$AppDatabase, $ResultsTable> {
  $$ResultsTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultsTable> {
  $$ResultsTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultsTable> {
  $$ResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalQuestions => $composableBuilder(
    column: $table.totalQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);
}

class $$ResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultsTable,
          Result,
          $$ResultsTableFilterComposer,
          $$ResultsTableOrderingComposer,
          $$ResultsTableAnnotationComposer,
          $$ResultsTableCreateCompanionBuilder,
          $$ResultsTableUpdateCompanionBuilder,
          (Result, BaseReferences<_$AppDatabase, $ResultsTable, Result>),
          Result,
          PrefetchHooks Function()
        > {
  $$ResultsTableTableManager(_$AppDatabase db, $ResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> difficulty = const Value.absent(),
                Value<int> totalQuestions = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
              }) => ResultsCompanion(
                id: id,
                category: category,
                difficulty: difficulty,
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                takenAt: takenAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String category,
                Value<String?> difficulty = const Value.absent(),
                required int totalQuestions,
                required int correctAnswers,
                Value<DateTime> takenAt = const Value.absent(),
              }) => ResultsCompanion.insert(
                id: id,
                category: category,
                difficulty: difficulty,
                totalQuestions: totalQuestions,
                correctAnswers: correctAnswers,
                takenAt: takenAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultsTable,
      Result,
      $$ResultsTableFilterComposer,
      $$ResultsTableOrderingComposer,
      $$ResultsTableAnnotationComposer,
      $$ResultsTableCreateCompanionBuilder,
      $$ResultsTableUpdateCompanionBuilder,
      (Result, BaseReferences<_$AppDatabase, $ResultsTable, Result>),
      Result,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ResultsTableTableManager get results =>
      $$ResultsTableTableManager(_db, _db.results);
}
