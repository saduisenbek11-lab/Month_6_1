import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_1/features/data/models/character_model.dart';

class CharacterApi {
  static const String _url = 'https://hp-api.onrender.com/api/characters';

  Future<List<CharacterModel>> fetchCharacters() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки данных');
    }
  }
}