import 'package:flutter/material.dart';
import 'package:test_1/features/data/models/character_model.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailPage({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.fullName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(character.image),
            ),

            const SizedBox(height: 20),

            Text(
              character.fullName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                title: const Text('Nickname'),
                subtitle: Text(character.nickname),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('House'),
                subtitle: Text(character.hogwartsHouse),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Actor'),
                subtitle: Text(character.interpretedBy),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Birthdate'),
                subtitle: Text(character.birthdate),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Index'),
                subtitle: Text(character.index.toString()),
              ),
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Children',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ...character.children.map(
              (child) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}