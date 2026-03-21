import 'addChto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPageState {
  final bool? isEmpty;
  AddPageState({this.isEmpty});
}

class AddCubit extends Cubit<AddPageState> {
  final TaskRepository repository;
  AddCubit(this.repository) : super(AddPageState(isEmpty: null));

  void addTask(String title) async {
    if (title.trim().isEmpty) {
      emit(AddPageState(isEmpty: true));
    } else {
      await repository.addTask(title);
      emit(AddPageState(isEmpty: false));
    }
  }
}