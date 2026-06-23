import 'package:get_it/get_it.dart';
import 'features/recipes/data/repositories/meal_repository_impl.dart';
import 'features/recipes/domain/repositories/meal_repository.dart';
import 'features/recipes/presentation/bloc/meal_bloc.dart';

import 'features/ideas/presentation/bloc/idea_bloc.dart';
import 'features/ideas/domain/repositories/idea_repository.dart';
import 'features/ideas/data/repositories/idea_repository_impl.dart';
import 'features/ideas/domain/usecases/get_ideas.dart';
import 'features/ideas/domain/usecases/add_idea.dart';
import 'features/ideas/domain/usecases/search_ideas.dart';
import 'features/ideas/domain/usecases/toggle_favorite.dart';
import 'features/ideas/domain/usecases/update_idea.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<MealRepository>(() => MealRepositoryImpl());

  sl.registerFactory(() => MealBloc(repository: sl()));

  sl.registerLazySingleton<IdeaRepository>(() => InMemoryIdeaRepository());

  sl.registerLazySingleton(() => GetIdeas(sl()));
  sl.registerLazySingleton(() => AddIdea(sl()));
  sl.registerLazySingleton(() => SearchIdeas(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => UpdateIdea(sl()));

  sl.registerFactory(
    () => IdeaBloc(
      getIdeas: sl(),
      addIdea: sl(),
      searchIdeas: sl(),
      toggleFavorite: sl(),
      updateIdea: sl(),
    ),
  );
}
