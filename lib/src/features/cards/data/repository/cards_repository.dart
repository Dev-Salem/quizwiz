// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class CardsRepository implements BaseCardsRepository {
  final FlashcardLocalDataSource _flashcardDataSource;
  final CollectionLocalDataSource _collectionDataSource;
  final BaseRemoteDataSource _remoteDataSource;
  const CardsRepository(
    this._flashcardDataSource,
    this._collectionDataSource,
    this._remoteDataSource,
  );

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

  @override
  EitherFlashcards generateFlashcards(File file) async {
    try {
      final result = await _remoteDataSource.generateFlashcards(file);
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit saveAllGeneratedFlashcard(
      String collectionUuid, List<Flashcard> flashcards) async {
    try {
      final result = await _flashcardDataSource.saveAllGeneratedFlashcard(
          collectionUuid, flashcards);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit combineCollections(FlashcardCollection mainCollection,
      FlashcardCollection secondaryCollection) async {
    try {
      final result = await _collectionDataSource.combineCollections(
          mainCollection, secondaryCollection);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}
