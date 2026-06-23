import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/idea.dart';
import '../bloc/idea_bloc.dart';
import '../bloc/idea_event.dart';

class AddIdeaPage extends StatefulWidget {
  const AddIdeaPage({super.key});

  @override
  State<AddIdeaPage> createState() => _AddIdeaPageState();
}

class _AddIdeaPageState extends State<AddIdeaPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _saveIdea() {
    if (!_formKey.currentState!.validate()) return;

    final idea = Idea(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim(),
      tags: _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList(),
      createdAt: DateTime.now(),
      isFavorite: false,
      difficulty: 6,
      potential: 7,
      timeToBuild: 6,
      profitability: 6,
      roadmap: Idea.defaultRoadmap(),
    );

    context.read<IdeaBloc>().add(AddIdeaEvent(idea));
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новая идея')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                _titleController,
                'Название',
                'Введите название идеи',
              ),
              const SizedBox(height: 14),
              _buildTextField(
                _descriptionController,
                'Описание',
                'Опишите идею подробнее',
                maxLines: 5,
              ),
              const SizedBox(height: 14),
              _buildTextField(
                _categoryController,
                'Категория',
                'Например: бизнес, ИТ, развитие',
              ),
              const SizedBox(height: 14),
              _buildTextField(
                _tagsController,
                'Теги',
                'Через запятую: Flutter, стартап, ИИ',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveIdea,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Сохранить идею'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) => value == null || value.trim().isEmpty
          ? 'Поле не может быть пустым'
          : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFF121A2B),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
