/*import 'package:drift';

class Todos extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 30)();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  TextColumn get date => text()();
}
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationCacheDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
} */