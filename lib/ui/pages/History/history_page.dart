import 'package:flutter/material.dart';
import 'package:flutter_application_88/data/local/app_database.dart';

class HistoryPage extends StatefulWidget {
  final AppDatabase database;

  const HistoryPage({super.key, required this.database});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'History',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<List<Result>>(
                  stream: widget.database.watchAllResults(),
                  // Передаем пустой список изначально, чтобы не было вечного индикатора загрузки
                  initialData: const [], 
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Ошибка базы данных: ${snapshot.error}'),
                      );
                    }

                    // Если идет первая загрузка И в snapshot вообще нет никаких данных (даже initialData)
                    if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF8E6CFF),
                        ),
                      );
                    }

                    final results = snapshot.data ?? [];

                    // Если база пустая или еще проверяется — пишем, что пусто
                    if (results.isEmpty) {
                      return const Center(
                        child: Text(
                          'История пуста',
                          style: TextStyle(color: Colors.black38, fontSize: 16),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: results.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final result = results[results.length - 1 - index];

                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category: ${result.category}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Correct answers: ${result.correctAnswers}/${result.totalQuestions}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Difficulty: ${result.difficulty ?? 'All'}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}