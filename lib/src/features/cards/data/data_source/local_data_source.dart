import 'package:isar/isar.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

abstract class BaseLocalDataSource {
  Future<List<Flashcard>> getFlashcards(int collectionId);
  Future<List<FlashcardCollection>> getCollections();

  Future<Unit> createCollection(String name, {description = ''});
  Future<Unit> addFlashcard(
      String question, String answer, String collectionUuid);

  Future<Unit> removeCollection(String uuid);
}

class IsarDataSource extends BaseLocalDataSource {
  final _instance = Isar.getInstance()!;
  final uuid = const Uuid();
  @override
  Future<Unit> addFlashcard(
      String question, String answer, String collectionUuid) async {
    final flashcard =
        Flashcard(question: question, answer: answer, uuid: uuid.v4());
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
  Future<List<Flashcard>> getFlashcards(int collectionId) async {
    final collection = await _instance.flashcardCollections
        .get(collectionId)
        .onError((error, stackTrace) =>
            throw LocalStorageException(message: error.toString()));
    return collection!.cards;
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
}
