import 'package:get_it/get_it.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    //data sources
    sl.registerLazySingleton(() => IsarCollectionDataSource());
    sl.registerLazySingleton(() => IsarFlashcardDataSource());
    sl.registerLazySingleton(() => DioRemoteDataSource());

    //repository
    sl.registerLazySingleton(
        () => CardsRepository(flashcards: sl(), collection: sl(), dio: sl()));
    //bloc
    sl.registerFactory<CardsBloc>(() => CardsBloc(repository: sl()));
  }
}
