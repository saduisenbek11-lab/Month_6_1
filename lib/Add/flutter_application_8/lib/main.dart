import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_8/Home/home.dart';
import 'Ekran/first.dart';
import 'nastroyki/Themepracticeappstate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final bool isSeen = prefs.getBool('isSeen') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (_) => Themepracticeappstate(),
      child: MyApp(showHome: isSeen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<Themepracticeappstate>(context).isDark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Заметки',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: showHome 
          ? const MyHomePage(title: 'Заметки') 
          : const First(),
    );
  }
}
class Task {
  String name;
  String description; // Новое поле
  bool isDone;
  Task({required this.name, this.description = "", this.isDone = false});
}