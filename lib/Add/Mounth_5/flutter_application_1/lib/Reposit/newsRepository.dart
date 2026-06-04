import 'package:flutter_application_1/Api/newsApiService.dart';
import 'package:flutter_application_1/Model/newsArticlemodel.dart';

class NewsRepository {
  final NewsApiService api;

  NewsRepository(this.api);

  Future<List<MovieModel>> getNews() {
    return api.getNews();
  }
}