import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/idea.dart';
import '../../domain/repositories/idea_repository.dart';
import '../models/idea_model.dart';

class InMemoryIdeaRepository implements IdeaRepository {
  static const String _storageKey = 'idea_vault_ideas';
  final List<IdeaModel> _ideas = [];
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      _ideas.addAll(
        decoded.map((item) => IdeaModel.fromJson(item as Map<String, dynamic>)),
      );
    } else {
      _ideas.addAll(_defaultIdeas());
      await _save();
    }

    _initialized = true;
  }

  List<IdeaModel> _defaultIdeas() {
    return [
      IdeaModel.fromEntity(
        Idea(
          id: '1',
          title: 'Приложение для поиска напарников в спортзал',
          description:
              'Помогает найти тренера или партнера по спорту в вашем городе.',
          category: 'Здоровье',
          tags: const ['Фитнес', 'Социальное'],
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          isFavorite: true,
          difficulty: 6,
          potential: 8,
          timeToBuild: 7,
          profitability: 7,
          roadmap: Idea.defaultRoadmap(),
        ),
      ),
      IdeaModel.fromEntity(
        Idea(
          id: '2',
          title: 'Онлайн-платформа для обучения детей',
          description:
              'Интерактивные курсы и домашние задания для младших школьников.',
          category: 'Образование',
          tags: const ['Образование', 'Дети'],
          createdAt: DateTime.now().subtract(const Duration(days: 13)),
          isFavorite: false,
          difficulty: 5,
          potential: 9,
          timeToBuild: 8,
          profitability: 8,
          roadmap: Idea.defaultRoadmap(),
        ),
      ),
    ];
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_ideas.map((idea) => idea.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  @override
  Future<void> addIdea(Idea idea) async {
    await _ensureInitialized();
    _ideas.insert(0, IdeaModel.fromEntity(idea));
    await _save();
  }

  @override
  Future<List<Idea>> getIdeas() async {
    await _ensureInitialized();
    return List<Idea>.unmodifiable(_ideas);
  }

  @override
  Future<List<Idea>> searchIdeas(String query) async {
    await _ensureInitialized();
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return getIdeas();
    }

    return _ideas
        .where((idea) {
          final text =
              '${idea.title} ${idea.description} ${idea.category} ${idea.tags.join(' ')}'
                  .toLowerCase();
          return text.contains(normalized);
        })
        .toList(growable: false);
  }

  @override
  Future<void> toggleFavorite(String ideaId) async {
    await _ensureInitialized();

    final index = _ideas.indexWhere((idea) => idea.id == ideaId);

    if (index >= 0) {
      final idea = _ideas[index];
      _ideas[index] = IdeaModel.fromEntity(
        idea.copyWith(isFavorite: !idea.isFavorite),
      );
      await _save();
    }
  }

  @override
  Future<void> updateIdea(Idea idea) async {
    await _ensureInitialized();
    final index = _ideas.indexWhere((item) => item.id == idea.id);
    if (index >= 0) {
      _ideas[index] = IdeaModel.fromEntity(idea);
      await _save();
    }
  }
}
