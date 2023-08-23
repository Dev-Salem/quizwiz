import 'package:quizwiz/src/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:uuid/uuid.dart';

abstract class FlashcardLocalDataSource {
  factory FlashcardLocalDataSource() => IsarFlashcardDataSource();
  Future<Unit> addFlashcard(
      String question, String answer, String collectionUuid);

  Future<List<Flashcard>> getDueReviewCards(
    FlashcardCollection collection,
  );
  Future<Unit> updateDueTime(
    Flashcard card,
    String collectionUuid,
    ReviewResult reviewResult,
  );
  Future<Unit> removeFlashcard(
      FlashcardCollection collection, String flashcardUuid);
  Future<Unit> editFlashcard(EditFlashcardParameters parameters);
  Future<List<MultipleChoiceQuiz>> getMultipleChoiceOptions(
      FlashcardCollection collection);
  Future<Unit> saveAllGeneratedFlashcard(
      String collectionUuid, List<Flashcard> flashcards);
}

class IsarFlashcardDataSource implements FlashcardLocalDataSource {
  final _instance = Isar.getInstance()!;
  final uuid = const Uuid();

  @override
  Future<Unit> addFlashcard(
      String question, String answer, String collectionUuid) async {
    final flashcard = Flashcard(
        question: question,
        answer: answer,
        uuid: uuid.v4(),
        dueTime: DateTime.now().millisecondsSinceEpoch);
    await _instance.writeTxn(() async {
      final collection =
          await _instance.flashcardCollections.getByUuid(collectionUuid);
      List<Flashcard> cards = [
        ...collection!.cards,
      ];
      cards.add(flashcard);
      await _instance.flashcardCollections
          .put(collection.copyWith(cards: cards));
    }).onError((error, stackTrace) =>
        throw LocalStorageException(message: error.toString()));
    return unit;
  }

  @override
  Future<List<Flashcard>> getDueReviewCards(
      FlashcardCollection collection) async {
    final cards = collection.cards.where((card) {
      return DateTime.fromMillisecondsSinceEpoch(card.dueTime)
          .isBefore(DateTime.now());
    }).toList();
    cards.shuffle();
    return cards;
  }

  @override
  Future<Unit> updateDueTime(
      Flashcard card, String collectionUuid, ReviewResult reviewResult) async {
    //make a new card with updated [dueReview, factor, interval]
    final newCard = CardCalculation(card).update(reviewResult);

    await _instance.writeTxn(() async {
      //get the old collection
      final collection =
          await _instance.flashcardCollections.getByUuid(collectionUuid);

      // make a new cards list where the old card is excluded and the new card is added
      List<Flashcard> newCardList = [];
      newCardList.addAll(collection!.cards
          .where((element) => element.uuid != card.uuid)
          .toList());
      newCardList.add(newCard);

      //update the collection with the new cards list
      await _instance.flashcardCollections
          .put(collection.copyWith(cards: newCardList));
    });
    return unit;
  }

  @override
  Future<Unit> removeFlashcard(
      FlashcardCollection collection, String flashcardUuid) async {
    await _instance.writeTxn(() async {
      await _instance.flashcardCollections.put(collection.copyWith(
          cards: collection.cards
              .where((element) => element.uuid != flashcardUuid)
              .toList()));
    });
    return unit;
  }

  @override
  Future<Unit> editFlashcard(EditFlashcardParameters parameters) async {
    await _instance.writeTxn(() async {
      final findCard = parameters.collection.cards
          .where((element) => element.uuid == parameters.flashcard.uuid);
      //create the updated card
      final newCard = findCard.single
          .copyWith(question: parameters.question, answer: parameters.answer);
      //create a new card list without the old card
      List<Flashcard> newList = parameters.collection.cards
          .where((element) => element.uuid != parameters.flashcard.uuid)
          .toList();
      //add the updated card to list
      newList.add(newCard);

      //update the collection
      await _instance.flashcardCollections
          .put(parameters.collection.copyWith(cards: newList));
    });
    return unit;
  }

  @override
  Future<List<MultipleChoiceQuiz>> getMultipleChoiceOptions(
      FlashcardCollection collection) async {
    List<MultipleChoiceQuiz> result = [];
    for (var element in collection.cards) {
      result.add(MultipleChoiceQuiz.fromCollection(
          card: element, collection: collection));
    }
    return result;
  }

  @override
  Future<Unit> saveAllGeneratedFlashcard(
      String collectionUuid, List<Flashcard> flashcards) async {
    _instance.writeTxn(() async {
      final collection =
          await _instance.flashcardCollections.getByUuid(collectionUuid);
      List<Flashcard> newCardsList = [...collection!.cards];
      newCardsList.addAll(flashcards);
      await _instance.flashcardCollections
          .put(collection.copyWith(cards: newCardsList));
    }).onError((error, stackTrace) =>
        throw LocalStorageException(message: error.toString()));
    return unit;
  }
}
