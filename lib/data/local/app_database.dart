import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Results extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get category => text().withLength(min: 1, max: 128)();

  TextColumn get difficulty => text().nullable()();

  IntColumn get totalQuestions =>
      integer().named('total_questions')();

  IntColumn get correctAnswers =>
      integer().named('correct_answers')();

  DateTimeColumn get takenAt =>
      dateTime().named('taken_at').withDefault(currentDateAndTime)();
}
@DriftDatabase(tables: [Results])
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase instance = AppDatabase._internal();

  @override
  int get schemaVersion => 1;

  Future<int> insertResult(ResultsCompanion entry) {
    return into(results).insert(entry);
  }

  Future<List<Result>> getAllResults() {
    return select(results).get();
  }
  Future<void> clearAllResults() {
  return delete(results).go();
}

  Stream<List<Result>> watchAllResults() {
    return select(results).watch();
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'app_db',
    native: const DriftNativeOptions(),
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}