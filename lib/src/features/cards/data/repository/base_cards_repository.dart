import 'package:quizwiz/src/core/core.dart';

abstract class BaseCardsRepository {
  EitherFlashcards getFlashcards(int collectionId);
  EitherCollections getCollections();
  EitherUnit createCollection(String name, {description = ''});
  EitherUnit addFlashcard(
      String question, String answer, String collectionUuid);
  EitherUnit removeCollection(String uuid);
}
