import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'Todos.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Todo>> getTodoList() {
  return select(todos).get();
  }

  Future<int> insertTodo(TodosCompanion todo) {
    return into(todos).insert(todo);
  }
  Future<int> updateTodo(int id ,TodosCompanion todo){
    return(update(todos)..where((t) => t.id.equals(id))).write(todo);
  }
  Future <int> deleteTodo(int id){
    return(delete(todos)..where((t) => t.id.equals(id))).go();
  }
   
}


LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationCacheDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}