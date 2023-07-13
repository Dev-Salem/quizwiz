import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:uuid/uuid.dart';

abstract class CollectionLocalDataSource {
  factory CollectionLocalDataSource() => IsarCollectionDataSource();
  Future<List<FlashcardCollection>> getCollections();
  Future<Unit> createCollection(String name, {description = ''});
  Future<Unit> removeCollection(String uuid);
  Future<Unit> editCollection(
      ({
        FlashcardCollection collection,
        String name,
        String description
      }) collection);
  Future<Unit> combineCollections(FlashcardCollection mainCollection,
      FlashcardCollection secondaryCollection);
}

class IsarCollectionDataSource implements CollectionLocalDataSource {
  final _instance = Isar.getInstance()!;
  final uuid = const Uuid();
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
  Future<Unit> removeCollection(String uuid) async {
    _instance.writeTxn(() async {
      await _instance.flashcardCollections.deleteByUuid(uuid).onError(
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
    return collections.reversed.toList();
  }

  @override
  Future<Unit> editCollection(
      ({
        FlashcardCollection collection,
        String description,
        String name
      }) collection) async {
    await _instance.writeTxn(() async {
      final newCollection = collection.collection
          .copyWith(name: collection.name, description: collection.description);
      await _instance.flashcardCollections.put(newCollection);
    }).onError((error, stackTrace) {
      throw LocalStorageException(message: error.toString());
    });
    return unit;
  }

  @override
  Future<Unit> combineCollections(FlashcardCollection mainCollection,
      FlashcardCollection secondaryCollection) async {
    List<Flashcard> newCardList = [
      ...mainCollection.cards,
      ...secondaryCollection.cards
    ];
    await _instance.writeTxn(() async {
      await _instance.flashcardCollections
          .put(mainCollection.copyWith(cards: newCardList));
    });
    return unit;
  }
}
