import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/create_flashcards_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/edit_flashcard_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/flashcards_list_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/home_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/practice_cards_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/review_result_screen.dart';

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
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>
              FlashcardsListScreen(collectionUuid: collectionUuid),
        );
      case '/practice_cards':
        var collection = settings.arguments as FlashcardCollection;
        return MaterialPageRoute(
          builder: (context) => PracticeCardsScreen(
            collection: collection,
          ),
        );
      case '/review_result':
        var cardAndCollection = settings.arguments as (
          Flashcard card,
          FlashcardCollection collection
        );
        return MaterialPageRoute(
          builder: (context) => ReviewResultScreen(
            cardAndCollection: cardAndCollection,
          ),
        );
      case '/edit_flashcard':
        var parameters = settings.arguments as EditFlashcardParameters;
        return MaterialPageRoute(
            builder: (context) => EditFlashcardScreen(
                  parameters: parameters,
                ));
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
