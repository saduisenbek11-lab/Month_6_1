import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';


class Todos extends Table{
 
  IntColumn get id=>integer().autoIncrement()();
  TextColumn get tittle=>text().withLength(min: 3,max: 30)();
  BoolColumn get isDone=>boolean().withDefault(const Constant(false))();
  TextColumn get date=>text()();


  


}class Toodo{
  final String tittle;
  final bool isDone;
  final String Date;
  VoidCallback onTap;
  Toodo({required this.tittle,required this.Date, this.isDone=false,required this.onTap});

}