import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/features/ui/bloc/bloc.dart';

import 'features/data/api/character_api.dart';
import 'features/ui/bloc/bloc_event.dart';
import 'features/ui/pages/harry_page.dart';
void main() {
  runApp(
    BlocProvider(
      create: (_) => CharacterBloc(CharacterApi())..add(LoadBloc()),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HarryPage(),
    );
  }
}