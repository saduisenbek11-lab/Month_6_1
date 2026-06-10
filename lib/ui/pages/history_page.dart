import 'package:flutter/material.dart';
import 'package:flutter_application_88/data/local/app_database.dart';
import 'package:flutter_application_88/main.dart';
import 'package:flutter_application_88/ui/pages/quiz_first_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Result>> _historyFuture;
   
   @override
void initState() {
  super.initState();

  _historyFuture = Future.value([
    Result(
      id: 1,
      category: "Test",
      difficulty: "easy",
      totalQuestions: 10,
      correctAnswers: 7,
      takenAt: DateTime.now(),
    )
  ]);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История'),
      ),
      body: FutureBuilder<List<Result>>(
        future: _historyFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final results = snapshot.data ?? [];

          if (results.isEmpty) {
            return const Center(
              child: Text('История пуста'),
            );
          }
         return Column(
  children: [
    Expanded(
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];

          final percent = result.totalQuestions == 0
              ? 0
              : (result.correctAnswers / result.totalQuestions) * 100;

          return ListTile(
            title: Text(result.category),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${result.correctAnswers}/${result.totalQuestions}'),
                const SizedBox(height: 4),
                Text('Сложность: ${result.difficulty ?? '-'}'),
                const SizedBox(height: 4),
                Text('Правильность: ${percent.toStringAsFixed(1)}%'),
              ],
            ),
            trailing: const Icon(Icons.history),
          );
        },
      ),
    ),

    Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
           Navigator.pushReplacement(
           context,
             MaterialPageRoute(
            builder: (context) => const QuizSetupPage(),
             ),
             );
          },
          child: const Text('← В начало'),
        ),
      ),
    ),
  ],
);
        },
      ),
    );
  }
}