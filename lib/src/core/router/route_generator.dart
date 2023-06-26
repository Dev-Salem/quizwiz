import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/create_flashcards.dart';
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
        var cards = settings.arguments as List<Flashcard>;
        return MaterialPageRoute(
          builder: (context) => PracticeCardsScreen(
            cards: cards,
          ),
        );
      case '/review_result':
        var card = settings.arguments as Flashcard;
        return MaterialPageRoute(
          builder: (context) => ReviewResultScreen(card: card),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
