import 'package:dartz/dartz.dart';
import 'package:quizwiz/src/core/errors/failure.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

typedef EitherFlashcards = Future<Either<Failure, List<Flashcard>>>;
typedef EitherCollections = Future<Either<Failure, List<FlashcardCollection>>>;
typedef EitherCollection = Future<Either<Failure, FlashcardCollection>>;
typedef EitherUnit = Future<Either<Failure, Unit>>;
typedef EitherMultiple = Future<Either<Failure, List<MultipleChoiceQuiz>>>;
