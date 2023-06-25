import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/core/errors/failure.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';

typedef EitherFlashcards = Future<Either<Failure, List<Flashcard>>>;
typedef EitherCollections = Future<Either<Failure, List<FlashcardCollection>>>;
typedef EitherUnit = Future<Either<Failure, Unit>>;
