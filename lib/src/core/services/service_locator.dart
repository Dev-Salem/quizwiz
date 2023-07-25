import 'package:get_it/get_it.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

final sl = GetIt.instance;

class ServiceLocator {
  void init() {
    //data sources
    sl.registerLazySingleton(() => CollectionLocalDataSource());
    sl.registerLazySingleton(() => FlashcardLocalDataSource());
    sl.registerLazySingleton(() => BaseRemoteDataSource());
    sl.registerLazySingleton<Isar>(() => Isar.getInstance()!);
    //repository
    sl.registerLazySingleton(() => BaseCardsRepository(sl(), sl(), sl()));
    //bloc
    sl.registerFactory<CardsBloc>(() => CardsBloc(sl(), sl()));
    sl.registerFactory(() => ThemeCubit());
  }
}
