// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';

abstract class CardsEvents extends Equatable {
  const CardsEvents();
  @override
  List<Object?> get props => [];
}

class GetCollectionsEvent extends CardsEvents {
  @override
  List<Object?> get props => [];
}

class RemoveCollectionEvent extends CardsEvents {
  final String uuid;
  const RemoveCollectionEvent({
    required this.uuid,
  });
  @override
  List<Object?> get props => [uuid];
}

class CreateCollectionsEvent extends CardsEvents {
  final String name;
  final String description;
  const CreateCollectionsEvent({
    required this.name,
    required this.description,
  });
}

class AddFlashcardsEvent extends CardsEvents {
  final String collectionUuid;
  final String front;
  final String back;
  const AddFlashcardsEvent({
    required this.collectionUuid,
    required this.front,
    required this.back,
  });
}

class UpdateDueTimeEvent extends CardsEvents {
  final Flashcard card;
  final String collectionUuid;
  final ReviewResult reviewResult;
  const UpdateDueTimeEvent({
    required this.card,
    required this.collectionUuid,
    required this.reviewResult,
  });
}

class RemoveFlashcardsEvent extends CardsEvents {
  final FlashcardCollection collection;
  final String flashcardUuid;
  const RemoveFlashcardsEvent({
    required this.collection,
    required this.flashcardUuid,
  });
}

class EditFlashcardsEvent extends CardsEvents {
  final EditFlashcardParameters parameters;
  const EditFlashcardsEvent({required this.parameters});
}

class GetDueReviewsEvent extends CardsEvents {
  final FlashcardCollection collection;
  const GetDueReviewsEvent({required this.collection});
}

class EditCollectionEvent extends CardsEvents {
  final String name;
  final String description;
  final FlashcardCollection collection;
  const EditCollectionEvent({
    required this.name,
    required this.description,
    required this.collection,
  });
}

class GetCollectionEvent extends CardsEvents {
  final String collectionUuid;
  const GetCollectionEvent({required this.collectionUuid});
}

class GetMultipleQuizOptionsEvent extends CardsEvents {
  final FlashcardCollection collection;

  const GetMultipleQuizOptionsEvent({required this.collection});
}
