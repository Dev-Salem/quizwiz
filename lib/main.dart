import 'package:flutter/material.dart';
import 'package:quizwiz/src/app.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'src/features/cards/data/data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await _initialize();
  runApp(QuizWizApp(
    cardsBloc: sl<CardsBloc>()..add(const GetCollectionsEvent()),
    themeCubit: sl(),
  ));
}

Future<void> _openIsarBox() async {
  final dir = await getApplicationDocumentsDirectory();
  await Isar.open([FlashcardCollectionSchema], directory: dir.path);
}

Future<void> _initialize() async {
  await dotenv.load(fileName: ".env");
  ServiceLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await _openIsarBox();
}
