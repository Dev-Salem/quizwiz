import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';

abstract class BaseCardsRepository {
  EitherFlashcards getDueReviewCards(
    FlashcardCollection collection,
  );
  EitherCollections getCollections();
  EitherUnit createCollection(String name, {description = ''});
  EitherUnit addFlashcard(
      String question, String answer, String collectionUuid);
  EitherUnit removeCollection(String uuid);
  EitherUnit updateDueTime(
    Flashcard card,
    String collectionUuid,
    ReviewResult reviewResult,
  );
  EitherUnit removeFlashcard(
      FlashcardCollection collection, String flashcardUuid);

  EitherUnit editFlashcard(EditFlashcardParameters parameters);
  EitherUnit editCollection(
      ({
        FlashcardCollection collection,
        String name,
        String description
      }) collection);
  EitherCollection getCollection(String collectionUuid);
  EitherMultiple getMultipleChoiceOptions(FlashcardCollection collection);
}
