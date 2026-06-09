import 'package:flutter/material.dart';
import 'package:flutter_application_88/ui/pages/history_page.dart';
import 'package:flutter_application_88/ui/pages/result_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_88/features/quiz/data/models/harry_model.dart';
import 'package:flutter_application_88/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:flutter_application_88/data/local/app_database.dart';
import 'package:drift/drift.dart' hide Column;

const Map<String, int?> categoryIds = {'All': null, 'Math': 19, 'Science': 17, 'History': 23, 'Geography': 22};
const Map<String, String?> difficultyValues = {'All': null, 'Easy': 'easy', 'Medium': 'medium', 'Hard': 'hard'};
class QuizSecondPage extends StatefulWidget {
  final int questionsCount;
  final String category;
  final String difficulty;

  const QuizSecondPage({
    super.key,
    required this.questionsCount,
    required this.category,
    required this.difficulty,
  });

  @override
  State<QuizSecondPage> createState() => _QuizSecondPageState();
}

class _QuizSecondPageState extends State<QuizSecondPage> {
  int _currentQuestion = 0;
  int _startedQuestion = -1;
  final Map<int, String> _selectedAnswers = {};
  List<String> _cachedAnswers = [];

  void _prepareAnswersOnce(HarryModel question) {
    if (_startedQuestion != _currentQuestion) {
      _cachedAnswers = [question.correctAnswer, ...question.incorrectAnswers]..shuffle();
      _startedQuestion = _currentQuestion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              if (state.status == QuizStatus.loading || state.status == QuizStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == QuizStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.errorMessage ?? 'Ошибка загрузки вопросов',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => context.read<QuizCubit>().loadQuiz(
                              amount: widget.questionsCount,
                              categoryId: categoryIds[widget.category],
                              difficulty: difficultyValues[widget.difficulty],
                            ),
                        child: const Text('Попробовать ещё раз'),
                      ),
                    ],
                  ),
                );
              }

              if (state.questions.isEmpty) {
                return const Center(child: Text('Нет загруженных вопросов'));
              }

              final question = state.questions[_currentQuestion];
              _prepareAnswersOnce(question);

              final isLastQuestion = _currentQuestion >= state.questions.length - 1;

              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.category,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildProgressBar(state.questions.length),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            question.question,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                          ),
                          const SizedBox(height: 32),
                          ...List.generate(_cachedAnswers.length, (index) {
                            return _buildAnswerButton(_cachedAnswers[index], state);
                          }),
                           const SizedBox(height: 28),
                          if (!isLastQuestion)
                           SizedBox(
                           width: 160,
                           height: 44,
                       child: FilledButton(
                         style: FilledButton.styleFrom(
                           backgroundColor: const Color(0xFFFF5E87),
                           shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(24),
                        ),
                    ),
                 onPressed: () {
              _moveToNextQuestion(state);
              },
             child: const Text(
          'Следующий',
         style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),

if (isLastQuestion)
  SizedBox(
    width: 160,
    height: 44,
    child: FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
  MaterialPageRoute(
    builder: (_) => const HistoryPage(),
  ),
);
      },
      child: const Text(
        'Завершить',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      ),
     ),
        ],
         ),
          ),
             ),
             ],
              );
            },
          ),
        ),
      ),
    );
  }
void _moveToNextQuestion(QuizState state) {
  if (_currentQuestion < state.questions.length - 1) {
    setState(() => _currentQuestion++);
  } else {
    _finishQuiz(state);
  }
}

Future<void> _finishQuiz(QuizState state) async {
  try {
    final total = state.questions.length;

    final correct = state.questions
        .asMap()
        .entries
        .where(
          (entry) =>
              _selectedAnswers[entry.key] ==
              entry.value.correctAnswer,
        )
        .length;

    await appDatabase.insertResult(
      ResultsCompanion.insert(
        category: widget.category,
        difficulty: widget.difficulty.isEmpty
            ? const Value.absent()
            : Value(widget.difficulty),
        totalQuestions: total,
        correctAnswers: correct,
      ),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HistoryPage(),
      ),
    );
  } catch (e) {
    debugPrint('Ошибка: $e');

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ошибка: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
  Widget _buildProgressBar(int questionsCount) {
    final progress = questionsCount > 0 ? (_currentQuestion + 1) / questionsCount : 0.0;

    return Column(
      children: [
        LinearProgressIndicator(
          value: progress,
          minHeight: 10,
          backgroundColor: const Color(0xFFE8E5F8),
          color: const Color(0xFF8E6CFF),
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(height: 10),
        Text(
          '${_currentQuestion + 1}/$questionsCount',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildAnswerButton(String answerText, QuizState state) {
    final hasAnswered = _selectedAnswers.containsKey(_currentQuestion);
    final isSelected = _selectedAnswers[_currentQuestion] == answerText;
    final bgColor = isSelected ? const Color(0xFFFB5A5A) : const Color(0xFF6170FF);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
         onPressed: hasAnswered
    ? null
    : () {
        setState(() {
          _selectedAnswers[_currentQuestion] = answerText;
        });

        if (!(_currentQuestion >= state.questions.length - 1)) {
          Future.delayed(const Duration(milliseconds: 600), () {
            if (!mounted) return;
            _moveToNextQuestion(state);
          });
        }
      },
          child: Text(
            answerText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}