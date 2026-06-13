
import 'package:test_1/features/data/models/character_model.dart';

abstract class BlocState  {}
final class BlocInitial extends BlocState {}
final class LoadingBloc extends BlocState {}
final class LoadedBloc extends BlocState{
final  List<CharacterModel> list;

  LoadedBloc({required this.list});
}
final class ErrorBloc extends BlocState{
  final String message;
  ErrorBloc({required this.message});
}