import 'package:dio/dio.dart';
import 'package:flutter_application_88/features/quiz/data/models/harry_model.dart';

class Repository {

  Future<List<HarryModel>> getQuiz({
    required int amount,
    int? categoryId,
    String? difficulty,
  }) async {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      responseType: ResponseType.json,
    ));
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

    try {
      final response = await dio.get(
        'https://opentdb.com/api.php',
        queryParameters: queryParameters,
      );

      List<dynamic> data = response.data['results'];
      final list = data.map((json) => HarryModel.fromJson(json)).toList();
      return list;
    } on DioException catch (error) {
      final message = error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout
          ? 'Сеть недоступна или запрос занял слишком много времени.'
          : 'Ошибка сети: ${error.message}';
      throw Exception(message);
    } catch (error) {
      throw Exception('Не удалось загрузить вопросы: ${error.toString()}');
    }
  }
}