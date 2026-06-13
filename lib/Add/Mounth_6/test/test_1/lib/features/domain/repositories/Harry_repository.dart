import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_1/features/data/models/character_model.dart';

class HarryRepository {
  final String url = 
  'https://potterapi.onrender.com/en/characters';

  Future<List<CharacterModel>> getCharacters() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
     final List data = jsonDecode(response.body);

     return data 
        .map((character) => CharacterModel.fromJson(character))
        .toList();
    }else{
      throw Text("Failed to load characters");
    }
  }
}