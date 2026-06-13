import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class QuizSetupPage extends StatefulWidget {
  const QuizSetupPage({super.key});

  @override
  State<QuizSetupPage> createState() => _QuizSetupPageState();
}

class _QuizSetupPageState extends State<QuizSetupPage> {
  int _questionsCount = 10;
  String _selectedCategory = 'All';
  String _selectedDifficulty = 'All';

  final List<String> _categories = ['All', 'Math', 'Science', 'History', 'Geography'];
  final List<String> _difficulties = ['All', 'Easy', 'Medium', 'Hard'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quiz',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
         child: Container(
         height: 130,
    width: 130,
     decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFD8C2FF), Color(0xFF8E6CFF)],
         begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(32),
       boxShadow: [
        BoxShadow(
          color: const Color(0xFF8E6CFF).withValues(alpha: 0.25),
           blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
     ),child: ClipRRect(
      borderRadius: BorderRadius.circular(32),
       child: const Center(
         child: Icon(
           Icons.quiz_outlined,
            size: 54,
              color: Colors.white,
              ),
                  ),
     ),
         ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Questions amount: $_questionsCount',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 10),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF8E6CFF),
                          inactiveTrackColor: const Color(0xFFE9E1FF),
                          thumbColor: const Color(0xFF8E6CFF),
                          overlayColor: const Color(0x296D4CFF),
                          trackHeight: 6,
                        ),
                        child: Slider(
                          value: _questionsCount.toDouble(),
                          min: 5,
                          max: 30,
                          label: _questionsCount.toString(),
                          onChanged: (value) {
                            setState(() {
                              _questionsCount = value.round();
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdown(
                        value: _selectedCategory,
                        items: _categories,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Difficulty',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildDropdown(
                        value: _selectedDifficulty,
                        items: _difficulties,
                        onChanged: (value) {
                          setState(() {
                            _selectedDifficulty = value!;
                          });
                        },
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFFF5E87),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/question',
                              arguments: {
                                'questionsCount': _questionsCount,
                                'category': _selectedCategory,
                                'difficulty': _selectedDifficulty,
                              },
                            );
                          },
                          child: const Text(
                            'Старт',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.deepPurple),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}