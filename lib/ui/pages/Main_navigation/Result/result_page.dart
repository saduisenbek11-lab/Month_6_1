import 'package:flutter/material.dart';
import 'package:flutter_application_88/ui/pages/Main_navigation/main_navigation_page.dart';

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
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                const Icon(
                  Icons.check,
                  size: 120,
                  color: Color(0xFF35D6B4),
                ),

                const SizedBox(height: 40),

                const Divider(),

                const SizedBox(height: 32),

                Text(
                  'Category: $category',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _InfoColumn(
                      title: 'Category',
                      value: category,
                    ),
                    _InfoColumn(
                      title: 'Correct Answers',
                      value: '$rightAnswers/$totalQuestions',
                    ),
                    _InfoColumn(
                      title: 'Score',
                      value: '$percent%',
                    ),
                  ],
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFF4F7B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                     Navigator.pushAndRemoveUntil(
                     context,
                      MaterialPageRoute(builder: (_) => const MainNavigationPage()),
                      (route) => false,
                     );
                    },
                    child: const Text(
                      'На главную',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const _InfoColumn({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}