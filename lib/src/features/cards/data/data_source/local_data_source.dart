import 'package:isar/isar.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/features/cards/data/models/card_calculation.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

abstract class BaseLocalDataSource {
  Future<List<Flashcard>> getDueReviewCards(
    FlashcardCollection collection,
  );
  Future<List<FlashcardCollection>> getCollections();

  Future<Unit> createCollection(String name, {description = ''});
  Future<Unit> addFlashcard(
      String question, String answer, String collectionUuid);

  Future<Unit> removeCollection(String uuid);
  Future<Unit> updateDueTime(
    Flashcard card,
    String collectionUuid,
    ReviewResult reviewResult,
  );
}

class IsarDataSource extends BaseLocalDataSource {
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
    _instance.writeTxn(() async {
      final collection =
          await _instance.flashcardCollections.getByUuid(collectionUuid);
      List<Flashcard> cards = [];
      cards.addAll(collection!.cards);
      cards.add(flashcard);
      await _instance.flashcardCollections
          .put(collection.copyWith(cards: cards));
    }).onError((error, stackTrace) =>
        throw LocalStorageException(message: error.toString()));
    return unit;
  }

  @override
  Future<Unit> createCollection(String name, {description = ''}) async {
    final collection = FlashcardCollection(
        name: name, description: description, uuid: uuid.v4());
    _instance.writeTxn(() async {
      await _instance.flashcardCollections.put(collection).onError(
          (error, stackTrace) =>
              throw LocalStorageException(message: error.toString()));
    });
    return unit;
  }

  @override
  Future<List<FlashcardCollection>> getCollections() async {
    final collections = await _instance.flashcardCollections
        .where()
        .findAll()
        .onError((error, stackTrace) =>
            throw LocalStorageException(message: error.toString()));
    return collections;
  }

  @override
  Future<List<Flashcard>> getDueReviewCards(
      FlashcardCollection collection) async {
    final cards = collection.cards
        .where((card) => DateTime.fromMillisecondsSinceEpoch(card.dueTime)
            .isBefore(DateTime.now()))
        .toList();
    return cards;
  }

  @override
  Future<Unit> removeCollection(String uuid) async {
    _instance.writeTxn(() async {
      await _instance.flashcardCollections.deleteByUuid(uuid).onError(
          (error, stackTrace) =>
              throw LocalStorageException(message: error.toString()));
    });
    return unit;
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
}
