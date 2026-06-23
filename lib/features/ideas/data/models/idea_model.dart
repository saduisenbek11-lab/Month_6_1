import '../../domain/entities/idea.dart';

class IdeaModel extends Idea {
  const IdeaModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.tags,
    required super.createdAt,
    required super.isFavorite,
    required super.difficulty,
    required super.potential,
    required super.timeToBuild,
    required super.profitability,
    required super.roadmap,
  });

  factory IdeaModel.fromEntity(Idea idea) {
    return IdeaModel(
      id: idea.id,
      title: idea.title,
      description: idea.description,
      category: idea.category,
      tags: idea.tags,
      createdAt: idea.createdAt,
      isFavorite: idea.isFavorite,
      difficulty: idea.difficulty,
      potential: idea.potential,
      timeToBuild: idea.timeToBuild,
      profitability: idea.profitability,
      roadmap: idea.roadmap,
    );
  }

  factory IdeaModel.fromJson(Map<String, dynamic> json) {
    return IdeaModel.fromEntity(Idea.fromJson(json));
  }
}
