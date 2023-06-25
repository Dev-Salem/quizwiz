import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

abstract class BaseCardsRepository {
  EitherFlashcards getDueReviewCards(
    FlashcardCollection collection,
  );
  EitherCollections getCollections();
  EitherUnit createCollection(String name, {description = ''});
  EitherUnit addFlashcard(
      String question, String answer, String collectionUuid);
  EitherUnit removeCollection(String uuid);
}
