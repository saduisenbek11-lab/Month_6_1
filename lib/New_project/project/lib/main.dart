import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/features/ideas/presentation/bloc/idea_bloc.dart';
import 'package:project/features/recipes/presentation/bloc/meal_bloc.dart';
import 'package:project/features/recipes/presentation/bloc/meal_event.dart';
import 'package:project/features/recipes/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<MealBloc>()..add(LoadMeals())),
        BlocProvider(create: (_) => di.sl<IdeaBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Умные рецепты',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFFEF9F5),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF7D31),
            primary: const Color(0xFFFF7D31),
            surface: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFEF9F5),
            elevation: 0,
            centerTitle: false,
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F1F1F),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
