import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/features/data/models/character_model.dart';
import 'package:test_1/features/ui/bloc/bloc.dart';
import 'package:test_1/features/ui/pages/detail.dart';
import '../bloc/bloc_state.dart';

class HarryPage extends StatelessWidget {
  const HarryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter'),
      ),
      body: BlocBuilder<CharacterBloc, BlocState>(
        builder: (context, state) {
          if (state is LoadingBloc) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoadedBloc) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                final CharacterModel character = state.list[index];

                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(character.image),
                    ),
                     title: Text(character.fullName), 
                    subtitle: Text(character.hogwartsHouse),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CharacterDetailPage(
                            character: character,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          if (state is ErrorBloc) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }
}