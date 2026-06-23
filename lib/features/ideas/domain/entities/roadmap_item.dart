import 'package:equatable/equatable.dart';

class RoadmapItem extends Equatable {
  final String title;
  final bool completed;

  const RoadmapItem({required this.title, required this.completed});

  RoadmapItem copyWith({String? title, bool? completed}) {
    return RoadmapItem(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'completed': completed};
  }

  factory RoadmapItem.fromJson(Map<String, dynamic> json) {
    return RoadmapItem(
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  @override
  List<Object?> get props => [title, completed];
}
