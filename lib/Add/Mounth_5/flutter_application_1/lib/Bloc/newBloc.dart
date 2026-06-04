import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/Bloc/newEvent.dart';
import 'package:flutter_application_1/Bloc/newState.dart';
import 'package:flutter_application_1/Reposit/newsRepository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
  }

  Future<void> _onLoadNews(
    LoadNews event,
    Emitter<NewsState> emit,
  ) async {
    emit(NewsLoading());

    try {
      final news = await repository.getNews();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}