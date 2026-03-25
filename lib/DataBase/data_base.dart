/*import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:todo_list_03flu/database/todos.dart';
part 'app_database.g.dart';

class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get hasSeenOnboarding => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Todos, Settings]) 
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

 
  Future<List<Todo>> getTodoList() => select(todos).get();
  Future<int> insertTodo(TodosCompanion todo) => into(todos).insert(todo);
  
 
  Future<bool> wasOnboardingSeen() async {
    final result = await select(settings).getSingleOrNull();
    return result?.hasSeenOnboarding ?? false;
  }

  Future setOnboardingSeen() async {
    return into(settings).insertOnConflictUpdate(
      const SettingsCompanion(
        id: Value(1), 
        hasSeenOnboarding: Value(true)
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
} */