import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/router/route_generator.dart';
import 'package:quizwiz/src/core/theme/app_theme.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'features/cards/data/data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openIsarBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsBloc(CardsRepository(
          IsarFlashcardDataSource(), IsarCollectionDataSource()))
        ..add(GetCollectionsEvent()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          home: const HomeScreen()),
    );
  }
}

Future<void> _openIsarBox() async {
  final dir = await getApplicationDocumentsDirectory();
  await Isar.open([FlashcardCollectionSchema], directory: dir.path);
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

//TODO: Edit collection
//TODO: Generate cards
//TODO: multiple choice quiz