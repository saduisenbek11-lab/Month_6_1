import 'package:dio/dio.dart';
import '../Model/newsArticlemodel.dart';

abstract class NewsApiService {
  Future<List<MovieModel>> getNews();
}

class NewsApiServiceImpl implements NewsApiService {
  final Dio dio;

  NewsApiServiceImpl({required this.dio});

  @override
  Future<List<MovieModel>> getNews() async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {
          'apiKey': 'fa6f80d5c5c84e61b1143f6c9a9a5f42 ', 
          'country': 'us', 
          'category': 'technology', 
        },
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception("Ошибка: ожидался JSON формат.");
      }

      if (!data.containsKey('articles') || data['articles'] == null) {
        throw Exception("В ответе API отсутствует поле 'articles'.");
      }

      final List results = data['articles'];

      return results.map((json) => MovieModel.fromJson(json)).toList();

    } on DioException catch (e) {
      final String errorMsg = e.response?.data?['message'] ?? e.message;
      throw Exception("Ошибка NewsAPI: $errorMsg");
    } catch (e) {
      throw Exception("Ошибка: $e");
    }
  }
}