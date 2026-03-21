import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'nastroyki/Themepracticeappstate.dart';
import 'package:flutter_application_3/Ekran/first.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Themepracticeappstate(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<Themepracticeappstate>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeState.thememode,
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
    
      home: const First(), 
    );
  }
}
class Task {
  final String name;
  final String title;
  bool isDone;
  Task({required this.name, this.isDone = false, required this.title});
}

