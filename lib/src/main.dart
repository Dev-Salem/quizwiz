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

/*Quizwiz is  an app that allows users to upload pdf files or paste 
texts to automatically generate flash cards, or manually adding cards The app allow two 
ways of reviewing cards 1) the typical front/back review
2) multiple choices
////////////////////////////////
Adding cards use case:
1) add cards manually
2) paste text and generate cards
3) upload pdf file and generate cards
--------------
reviewing cards use cases:
1) Review front/back
2) Review using multiple choice
-------------------
apis:
cache collection
generate collection then cache them
--------------------
user's flow 1
Enter the app -> add collection button ->
manually-> enter a front, back, example -> add -> cache
paste text-> enter the text -> loading -> show generated cards -> add them all / add part of them -> cache

user's flow 2
Enter the app -> click review cards -> show only cards needed for collection

*/
 
