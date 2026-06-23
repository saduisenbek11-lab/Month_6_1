import 'package:equatable/equatable.dart';

import 'roadmap_item.dart';

class Idea extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final List<String> tags;
  final DateTime createdAt;
  final bool isFavorite;
  final int difficulty;
  final int potential;
  final int timeToBuild;
  final int profitability;
  final List<RoadmapItem> roadmap;

  const Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.createdAt,
    required this.isFavorite,
    required this.difficulty,
    required this.potential,
    required this.timeToBuild,
    required this.profitability,
    required this.roadmap,
  });

  Idea copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    List<String>? tags,
    DateTime? createdAt,
    bool? isFavorite,
    int? difficulty,
    int? potential,
    int? timeToBuild,
    int? profitability,
    List<RoadmapItem>? roadmap,
  }) {
    return Idea(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      difficulty: difficulty ?? this.difficulty,
      potential: potential ?? this.potential,
      timeToBuild: timeToBuild ?? this.timeToBuild,
      profitability: profitability ?? this.profitability,
      roadmap: roadmap ?? this.roadmap,
    );
  }

  double get rating {
    return (difficulty + potential + timeToBuild + profitability) / 4;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
      'isFavorite': isFavorite,
      'difficulty': difficulty,
      'potential': potential,
      'timeToBuild': timeToBuild,
      'profitability': profitability,
      'roadmap': roadmap.map((item) => item.toJson()).toList(),
    };
  }

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      tags: List<String>.from(json['tags'] as List<dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isFavorite: json['isFavorite'] as bool,
      difficulty: json['difficulty'] as int,
      potential: json['potential'] as int,
      timeToBuild: json['timeToBuild'] as int,
      profitability: json['profitability'] as int,
      roadmap: (json['roadmap'] as List<dynamic>)
          .map((item) => RoadmapItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<RoadmapItem> defaultRoadmap() {
    return const [
      RoadmapItem(title: 'Исследование', completed: false),
      RoadmapItem(title: 'Дизайн', completed: false),
      RoadmapItem(title: 'MVP', completed: false),
      RoadmapItem(title: 'Тестирование', completed: false),
      RoadmapItem(title: 'Публикация', completed: false),
    ];
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    tags,
    createdAt,
    isFavorite,
    difficulty,
    potential,
    timeToBuild,
    profitability,
    roadmap,
  ];
}
