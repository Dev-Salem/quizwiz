import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/create_flashcards.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/flashcards_list_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/create_flashcards':
        var uuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CreateFlashcardsScreen(
                  collectionUuid: uuid,
                ));
      case '/flashcards_list':
        var collection = settings.arguments as FlashcardCollection;
        return MaterialPageRoute(
          builder: (context) => FlashcardsListScreen(collection: collection),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
