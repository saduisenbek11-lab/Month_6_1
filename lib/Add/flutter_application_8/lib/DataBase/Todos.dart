import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get title => text().withLength(min: 3, max: 30)();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();
  TextColumn get date => text()();
}
class Todo{
  final String tittle;
  final String id;
  final String name;
  final bool isDone;
  final String Date;
  VoidCallback onTap;
  Todo({required this.tittle,required this.name,required this.id,required this.Date, this.isDone=false,required this.onTap,});
}