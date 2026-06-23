import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/idea_bloc.dart';
import '../bloc/idea_event.dart';
import '../bloc/idea_state.dart';
import '../widgets/idea_card.dart';
import 'add_idea_page.dart';
import 'idea_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Хранилище идей'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _SearchBar(),
            const SizedBox(height: 14),
            const _FilterChips(),
            const SizedBox(height: 20),
            Expanded(child: _IdeaList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить идею',
        onPressed: () async {
          final created = await Navigator.of(
            context,
          ).push<bool>(MaterialPageRoute(builder: (_) => const AddIdeaPage()));

          if (created == true && context.mounted) {
            context.read<IdeaBloc>().add(const LoadIdeas());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          context.read<IdeaBloc>().add(SearchIdeasEvent(value)),
      decoration: InputDecoration(
        hintText: 'Поиск по идеям',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFF121A2B),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _IdeaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdeaBloc, IdeaState>(
      builder: (context, state) {
        if (state.filteredIdeas.isEmpty) {
          return const Center(
            child: Text(
              'Идей пока нет. Добавьте новую идею через кнопку "+".',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          );
        }

        return ListView.separated(
          itemCount: state.filteredIdeas.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final idea = state.filteredIdeas[index];
            return IdeaCard(
              idea: idea,
              onFavoriteToggle: () {
                context.read<IdeaBloc>().add(ToggleFavoriteEvent(idea.id));
              },
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => IdeaDetailPage(idea: idea)),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdeaBloc, IdeaState>(
      builder: (context, state) {
        return Row(
          children: [
            ChoiceChip(
              label: const Text('Все'),
              selected: !state.onlyFavorites,
              onSelected: (_) => context.read<IdeaBloc>().add(
                const FilterFavoritesEvent(false),
              ),
              selectedColor: const Color(0xFF8B5CF6),
              backgroundColor: const Color(0xFF121A2B),
            ),
            const SizedBox(width: 10),
            ChoiceChip(
              label: const Text('Избранное'),
              selected: state.onlyFavorites,
              onSelected: (_) => context.read<IdeaBloc>().add(
                const FilterFavoritesEvent(true),
              ),
              selectedColor: const Color(0xFF22C55E),
              backgroundColor: const Color(0xFF121A2B),
            ),
          ],
        );
      },
    );
  }
}
