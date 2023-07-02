// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';
import 'package:quizwiz/src/features/cards/data/repository/base_cards_repository.dart';

class CardsRepository extends BaseCardsRepository {
  final IsarFlashcardDataSource _flashcardDataSource;
  final IsarCollectionDataSource _collectionDataSource;

  CardsRepository(this._flashcardDataSource, this._collectionDataSource);

  @override
  EitherUnit addFlashcard(
      String question, String answer, String collectionUuid) async {
    try {
      final result = await _flashcardDataSource.addFlashcard(
          question, answer, collectionUuid);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit createCollection(String name, {description = ''}) async {
    try {
      final result = await _collectionDataSource.createCollection(name,
          description: description);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherCollections getCollections() async {
    try {
      final result = await _collectionDataSource.getCollections();
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherFlashcards getDueReviewCards(
    FlashcardCollection collection,
  ) async {
    try {
      final result = await _flashcardDataSource.getDueReviewCards(collection);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit removeCollection(String uuid) async {
    try {
      final result = await _collectionDataSource.removeCollection(uuid);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit updateDueTime(
      Flashcard card, String collectionUuid, ReviewResult reviewResult) async {
    try {
      final result = await _flashcardDataSource.updateDueTime(
          card, collectionUuid, reviewResult);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit removeFlashcard(
      FlashcardCollection collection, String flashcardUuid) async {
    try {
      final result =
          await _flashcardDataSource.removeFlashcard(collection, flashcardUuid);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit editFlashcard(EditFlashcardParameters parameters) async {
    try {
      final result = await _flashcardDataSource.editFlashcard(parameters);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit editCollection(
      ({
        FlashcardCollection collection,
        String description,
        String name
      }) collection) async {
    try {
      final result = await _collectionDataSource.editCollection(collection);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherCollection getCollection(String collectionUuid) async {
    try {
      final result = await _collectionDataSource.getCollection(collectionUuid);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherMultiple getMultipleChoiceOptions(
      FlashcardCollection collection) async {
    try {
      final result =
          await _flashcardDataSource.getMultipleChoiceOptions(collection);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}
