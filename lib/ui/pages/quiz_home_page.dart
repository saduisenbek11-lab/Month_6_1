import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_88/features/quiz/data/models/harry_model.dart';
import 'package:flutter_application_88/features/quiz/presentation/cubit/quiz_cubit.dart';

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

class QuizHomePage extends StatefulWidget {
  final int questionsCount;
  final String category;
  final String difficulty;

  const QuizHomePage({
    super.key,
    required this.questionsCount,
    required this.category,
    required this.difficulty,
  });

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  int _currentQuestion = 0;

  @override
  void initState() {
    super.initState();
    _currentQuestion = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              if (state.status == QuizStatus.loading || state.status == QuizStatus.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
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
                        onPressed: () {
                          context.read<QuizCubit>().loadQuiz(
                                amount: widget.questionsCount,
                                categoryId: categoryIds[widget.category],
                                difficulty: difficultyValues[widget.difficulty],
                              );
                        },
                        child: const Text('Попробовать ещё раз'),
                      ),
                    ],
                  ),
                );
              }

              if (state.questions.isEmpty) {
                return const Center(
                  child: Text('Нет загруженных вопросов'),
                );
              }

              final question = state.questions[_currentQuestion];
              final answers = _buildAnswerOptions(question);
              final isLastQuestion = _currentQuestion >= state.questions.length - 1;

              return Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black87,
                        ),
                      ),
                    ],
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
                        ...answers.map((answer) => _buildAnswerButton(answer)),
                        const SizedBox(height: 28),
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
                              if (!isLastQuestion) {
                                setState(() {
                                  _currentQuestion++;
                                });
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              isLastQuestion ? 'Завершить' : 'Следующий',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildProgressBar(int questionsCount) {
    final progress = questionsCount > 0 
        ? math.min(1.0, math.max(0.0, (_currentQuestion + 1) / questionsCount)) 
        : 0.0;

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E5F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                
                Container(
                  height: 10,
                  width: constraints.maxWidth * progress,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8E6CFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            );
          },
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

  List<_AnswerOption> _buildAnswerOptions(HarryModel question) {
    final answers = [question.correctAnswer, ...question.incorrectAnswers]..shuffle();
    final colors = [
      const Color(0xFF6170FF),
      const Color(0xFF32D7A0),
      const Color(0xFFFB5A5A),
      Colors.white,
    ];
    final textColors = [
      Colors.white,
      Colors.white,
      Colors.white,
      const Color(0xFF6170FF),
    ];

    return List.generate(
      answers.length,
      (index) => _AnswerOption(
        text: answers[index],
        color: colors[index % colors.length],
        textColor: textColors[index % textColors.length],
        borderColor: answers[index] == question.correctAnswer ? null : const Color(0xFF6170FF),
      ),
    );
  }

  Widget _buildAnswerButton(_AnswerOption answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: answer.color,
            foregroundColor: answer.textColor,
            elevation: 0,
            side: answer.borderColor != null 
                ? BorderSide(color: answer.borderColor!, width: 2) 
                : BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () {},
          child: Text(
            answer.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: answer.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerOption {
  final String text;
  final Color color;
  final Color textColor;
  final Color? borderColor;

  const _AnswerOption({
    required this.text,
    required this.color,
    required this.textColor,
    this.borderColor,
  });
}