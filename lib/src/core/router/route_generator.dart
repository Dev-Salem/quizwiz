import 'package:quizwiz/src/core/router/router_constance.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

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
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => GenerateCardsScreen(
                  collectionUuid: collectionUuid,
                ));
      case RouterConstance.goToQuiz:
        return MaterialPageRoute(
            builder: (context) => const MultipleChoiceQuizScreen());
      case RouterConstance.goToGeneratedFlashcards:
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) =>
                GeneratedFlashcardsScreen(collectionUuid: collectionUuid));
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
