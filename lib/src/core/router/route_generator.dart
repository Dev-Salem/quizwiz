import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/router/router_constance.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/create_flashcards_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/edit_flashcard_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/flashcards_list_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/generate_cards_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/generated_flashcards_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/home_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/multiple_choic_quiz_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/practice_cards_screen.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/review_result_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouterConstance.goToCreateFlashcards:
        var uuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CreateFlashcardsScreen(
                  collectionUuid: uuid,
                ));
      case RouterConstance.goToFlashcardsList:
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>
              FlashcardsListScreen(collectionUuid: collectionUuid),
        );
      case RouterConstance.goToPracticeCards:
        var collection = settings.arguments as FlashcardCollection;
        return MaterialPageRoute(
          builder: (context) => PracticeCardsScreen(
            collection: collection,
          ),
        );
      case RouterConstance.goToReviewResult:
        var cardAndCollection = settings.arguments as (
          Flashcard card,
          FlashcardCollection collection
        );
        return MaterialPageRoute(
          builder: (context) => ReviewResultScreen(
            cardAndCollection: cardAndCollection,
          ),
        );
      case RouterConstance.goToEditFlashcard:
        var parameters = settings.arguments as EditFlashcardParameters;
        return MaterialPageRoute(
            builder: (context) => EditFlashcardScreen(
                  parameters: parameters,
                ));
      case RouterConstance.goToGenerateFlashcards:
        var collection = settings.arguments as FlashcardCollection;
        return MaterialPageRoute(
            builder: (context) => GenerateCardsScreen(
                  collection: collection,
                ));
      case RouterConstance.goToQuiz:
        return MaterialPageRoute(
            builder: (context) => const MultipleChoiceQuizScreen());
      case RouterConstance.goToGeneratedFlashcards:
        var collection = settings.arguments as FlashcardCollection;
        return MaterialPageRoute(
            builder: (context) =>
                GeneratedFlashcardsScreen(collection: collection));
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
