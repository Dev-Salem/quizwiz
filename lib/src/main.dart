import 'package:flutter/material.dart';
import 'package:quizwiz/src/app_entry.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:path_provider/path_provider.dart';
import 'features/cards/data/data.dart';

Future<void> main() async {
  await _initialize();
  runApp(const QuizWizApp());
}

Future<void> _openIsarBox() async {
  final dir = await getApplicationDocumentsDirectory();
  await Isar.open([FlashcardCollectionSchema], directory: dir.path);
}

Future<void> _initialize() async {
  ServiceLocator().init();
  WidgetsFlutterBinding.ensureInitialized();
  await _openIsarBox();
}
