// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data_source/local_data_source.dart';
import 'package:quizwiz/src/features/cards/data/repository/base_cards_repository.dart';

class CardsRepository extends BaseCardsRepository {
  final IsarDataSource _dataSource;
  CardsRepository(this._dataSource);

  @override
  EitherUnit addFlashcard(
      String question, String answer, int collectionId) async {
    try {
      final result =
          await _dataSource.addFlashcard(question, answer, collectionId);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit createCollection(String name, {description = ''}) async {
    try {
      final result =
          await _dataSource.createCollection(name, description: description);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherCollections getCollections() async {
    try {
      final result = await _dataSource.getCollections();
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherFlashcards getFlashcards(int collectionId) async {
    try {
      final result = await _dataSource.getFlashcards(collectionId);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }

  @override
  EitherUnit removeCollection(String uuid) async {
    try {
      final result = await _dataSource.removeCollection(uuid);
      return Right(result);
    } on Exception catch (e) {
      return Left(LocalStorageFailure(message: e.toString()));
    }
  }
}
