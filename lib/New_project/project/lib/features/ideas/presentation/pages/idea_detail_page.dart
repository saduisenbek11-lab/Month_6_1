import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/idea.dart';
import '../../domain/entities/roadmap_item.dart';
import '../bloc/idea_bloc.dart';
import '../bloc/idea_event.dart';
import '../bloc/idea_state.dart';

class IdeaDetailPage extends StatelessWidget {
  final Idea idea;

  const IdeaDetailPage({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали идеи')),
      body: BlocBuilder<IdeaBloc, IdeaState>(
        builder: (context, state) {
          final currentIdea = state.ideas.firstWhere(
            (item) => item.id == idea.id,
            orElse: () => idea,
          );

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                _buildHeader(context, currentIdea),
                const SizedBox(height: 24),
                _buildSectionTitle('Описание'),
                const SizedBox(height: 10),
                Text(
                  currentIdea.description,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 22),
                _buildSectionTitle('Параметры'),
                const SizedBox(height: 12),
                _buildRatingRow('Сложность', currentIdea.difficulty),
                _buildRatingRow('Потенциал', currentIdea.potential),
                _buildRatingRow('Время разработки', currentIdea.timeToBuild),
                _buildRatingRow('Прибыльность', currentIdea.profitability),
                const SizedBox(height: 18),
                _buildSectionTitle('Общий рейтинг'),
                const SizedBox(height: 10),
                _buildAverageRating(currentIdea.rating),
                const SizedBox(height: 22),
                _buildSectionTitle('План развития'),
                const SizedBox(height: 12),
                ...currentIdea.roadmap.map(
                  (item) => _buildRoadmapItem(context, currentIdea, item),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Idea idea) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                idea.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                idea.category,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: idea.tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: const Color(0xFF1F2937),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Избранное',
          icon: Icon(
            idea.isFavorite ? Icons.star : Icons.star_border,
            color: idea.isFavorite ? Colors.amber : Colors.white70,
          ),
          onPressed: () {
            context.read<IdeaBloc>().add(ToggleFavoriteEvent(idea.id));
          },
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildRatingRow(String title, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.white70)),
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildAverageRating(double value) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: value / 10,
            color: const Color(0xFF22C55E),
            backgroundColor: const Color(0xFF1A2332),
            minHeight: 10,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildRoadmapItem(BuildContext context, Idea idea, RoadmapItem item) {
    return CheckboxListTile(
      value: item.completed,
      title: Text(item.title, style: const TextStyle(color: Colors.white70)),
      activeColor: const Color(0xFF22C55E),
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        final updatedRoadmap = idea.roadmap.map((roadmapItem) {
          if (roadmapItem.title != item.title) return roadmapItem;
          return roadmapItem.copyWith(completed: value ?? false);
        }).toList();

        final updatedIdea = idea.copyWith(roadmap: updatedRoadmap);
        context.read<IdeaBloc>().add(UpdateIdeaEvent(updatedIdea));
      },
    );
  }
}
