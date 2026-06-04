import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_88/features/quiz/data/repositories/repository.dart';
import 'package:flutter_application_88/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'ui/pages/quiz_home_page.dart';
import 'ui/pages/quiz_setup_page.dart';

const Map<String, int?> categoryIds = {
  'All': null,
  'Math': 19,
  'Science': 17,
  'History': 23,
  'Geography': 22,
};

const Map<String, String?> difficultyValues = {
  'All': null,
  'Easy': 'easy',
  'Medium': 'medium',
  'Hard': 'hard',
};

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const QuizSetupPage(),
      routes: {
        '/setup': (context) => const QuizSetupPage(),
        '/question': (context) {
          final dynamic args = ModalRoute.of(context)?.settings.arguments;
          if (args is! Map<String, dynamic>) {
            return const QuizSetupPage();
          }

          final questionsCount = args['questionsCount'] is int ? args['questionsCount'] as int : 10;
          final category = args['category'] is String ? args['category'] as String : 'All';
          final difficulty = args['difficulty'] is String ? args['difficulty'] as String : 'All';

          return BlocProvider(
            create: (_) => QuizCubit(Repository())
              ..loadQuiz(
                amount: questionsCount,
                categoryId: categoryIds[category],
                difficulty: difficultyValues[difficulty],
              ),
            child: QuizHomePage(
              questionsCount: questionsCount,
              category: category,
              difficulty: difficulty,
            ),
          );
        },
      },
    );
  }
}
