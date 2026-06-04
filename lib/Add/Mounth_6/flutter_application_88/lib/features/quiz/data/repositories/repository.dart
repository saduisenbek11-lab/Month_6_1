import 'package:dio/dio.dart';
import 'package:flutter_application_88/features/quiz/data/models/harry_model.dart';

class Repository {

  Future<List<HarryModel>> getQuiz({
    required int amount,
    int? categoryId,
    String? difficulty,
  }) async {
    final dio = Dio();
    final queryParameters = <String, dynamic>{
      'amount': amount,
      'type': 'multiple',
    };

    if (categoryId != null) {
      queryParameters['category'] = categoryId;
    }
    if (difficulty != null && difficulty.isNotEmpty) {
      queryParameters['difficulty'] = difficulty;
    }

    final response = await dio.get(
      'https://opentdb.com/api.php',
      queryParameters: queryParameters,
    );

    List<dynamic> data = response.data['results'];
    final list = data.map((json) => HarryModel.fromJson(json)).toList();
    return list;
  }
}