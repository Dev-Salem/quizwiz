import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'dart:io';

abstract class BaseCardsRepository {
  factory BaseCardsRepository(
          FlashcardLocalDataSource flashcardLocalDataSource,
          CollectionLocalDataSource collectionLocalDataSource,
          BaseRemoteDataSource baseRemoteDataSource) =>
      CardsRepository(flashcardLocalDataSource, collectionLocalDataSource,
          baseRemoteDataSource);

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
  EitherMultiple getMultipleChoiceOptions(FlashcardCollection collection);
  EitherFlashcards generateFlashcards(File file);
  EitherUnit saveAllGeneratedFlashcard(
      String collectionUuid, List<Flashcard> flashcards);
  EitherUnit combineCollections(FlashcardCollection mainCollection,
      FlashcardCollection secondaryCollection);
}
