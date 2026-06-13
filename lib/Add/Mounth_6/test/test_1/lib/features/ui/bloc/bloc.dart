import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/features/data/api/character_api.dart';
import 'package:test_1/features/ui/bloc/bloc_event.dart';
import 'package:test_1/features/ui/bloc/bloc_state.dart';

class CharacterBloc extends Bloc<BlocEvent, BlocState> {
  final CharacterApi api;

  CharacterBloc(this.api) : super(BlocInitial()) {
    on<LoadBloc>(_loadCharacters);
  }

  Future<void> _loadCharacters(
    LoadBloc event,
    Emitter<BlocState> emit,
  ) async {
    try {
      emit(LoadingBloc());

      final characters = await api.fetchCharacters();

      emit(LoadedBloc(list: characters));
    } catch (e) {
      emit(ErrorBloc(message: e.toString()));
    }
  }
}