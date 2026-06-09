import 'package:flutter/material.dart';
import 'package:flutter_application_88/data/local/app_database.dart';

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
    _historyFuture = appDatabase.getAllResults();
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

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
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

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];

              return ListTile(
                title: Text(result.category),
                subtitle: Text(
                  '${result.correctAnswers}/${result.totalQuestions}',
                ),
                trailing: Text(
                  result.difficulty ?? '-',
                ),
              );
            },
          );
        },
      ),
    );
  }
}