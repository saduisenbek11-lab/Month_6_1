import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_3/Home/home.dart';
import 'package:flutter_application_3/Ekran/first.dart';
import 'package:flutter_application_3/nastroyki/Themepracticeappstate.dart';

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
      title: 'Ваши задачи',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: showHome 
          ? const MyHomePage(title: 'Ваши задачи') 
          : const First(),
    );
  }
}

class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}