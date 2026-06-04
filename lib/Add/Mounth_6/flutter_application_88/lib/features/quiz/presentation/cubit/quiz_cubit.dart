import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_88/features/quiz/data/models/harry_model.dart';
import 'package:flutter_application_88/features/quiz/data/repositories/repository.dart';

enum QuizStatus { initial, loading, success, failure }

class QuizState {
  final QuizStatus status;
  final List<HarryModel> questions;
  final String? errorMessage;

  const QuizState({
    required this.status,
    required this.questions,
    this.errorMessage,
  });

  factory QuizState.initial() {
    return const QuizState(
      status: QuizStatus.initial,
      questions: [],
      errorMessage: null,
    );
  }

  QuizState copyWith({
    QuizStatus? status,
    List<HarryModel>? questions,
    String? errorMessage,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage,
    );
  }
}

class QuizCubit extends Cubit<QuizState> {
  final Repository repository;

  QuizCubit(this.repository) : super(QuizState.initial());

  Future<void> loadQuiz({
    required int amount,
    int? categoryId,
    String? difficulty,
  }) async {
    emit(state.copyWith(status: QuizStatus.loading, errorMessage: null));

    try {
      final questions = await repository.getQuiz(
        amount: amount,
        categoryId: categoryId,
        difficulty: difficulty,
      );
      emit(state.copyWith(status: QuizStatus.success, questions: questions));
    } catch (error) {
      emit(state.copyWith(
        status: QuizStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
