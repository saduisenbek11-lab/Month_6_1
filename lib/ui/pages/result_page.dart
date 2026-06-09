import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  final int rightAnswers;
  final int totalQuestions;
  final String category;
  final int percent;

  const QuizResultPage({
    super.key,
    required this.rightAnswers,
    required this.totalQuestions,
    required this.category,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$rightAnswers/$totalQuestions',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$percent%',
                    style: const TextStyle(fontSize: 30),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    category,
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5E87),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text(
                    'На главную',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}