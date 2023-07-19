import 'package:quizwiz/src/core/router/router_constance.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';
import 'package:quizwiz/src/features/cards/presentation/screens/writing_quiz_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.goToCreateFlashcards:
        var uuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => CreateFlashcardsScreen(
                  collectionUuid: uuid,
                ));
      case Routes.goToFlashcardsList:
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) =>
              FlashcardsListScreen(collectionUuid: collectionUuid),
        );
      case Routes.goToPracticeCards:
        var collection = settings.arguments as FlashcardCollection;
        return MaterialPageRoute(
          builder: (context) => PracticeCardsScreen(
            collection: collection,
          ),
        );
      case Routes.goToReviewResult:
        var cardAndCollection = settings.arguments as (
          Flashcard card,
          FlashcardCollection collection
        );
        return MaterialPageRoute(
          builder: (context) => ReviewResultScreen(
            cardAndCollection: cardAndCollection,
          ),
        );
      case Routes.goToEditFlashcard:
        var parameters = settings.arguments as EditFlashcardParameters;
        return MaterialPageRoute(
            builder: (context) => EditFlashcardScreen(
                  parameters: parameters,
                ));
      case Routes.goToGenerateFlashcards:
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => GenerateCardsScreen(
                  collectionUuid: collectionUuid,
                ));
      case Routes.goToQuiz:
        return MaterialPageRoute(
            builder: (context) => const MultipleChoiceQuizScreen());
      case Routes.goToGeneratedFlashcards:
        var collectionUuid = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) =>
                GeneratedFlashcardsScreen(collectionUuid: collectionUuid));
      case Routes.goToWritingQuiz:
        var flashcards = settings.arguments as List<Flashcard>;
        return MaterialPageRoute(
          builder: (context) => WritingQuizScreen(flashcards: flashcards),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const CustomErrorWidget(),
        );
    }
  }
}
