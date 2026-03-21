import 'package:flutter_application_3/Todo.dart';
class HomeState {
  final List<Todo> item ;
  final bool isError;

  const HomeState ({required this.isError , required this.item});

  factory HomeState.initial() => const HomeState(isError: false, item: []);

  HomeState copyWith({
    List<Todo>? item,
    bool? isError
  }){
    return HomeState(isError:  isError ?? this.isError, item: item ?? this.item);
  }
}