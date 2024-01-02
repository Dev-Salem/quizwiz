// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class CardsEvents extends Equatable {
  const CardsEvents();
  @override
  List<Object?> get props => [];
}

class GetCollectionsEvent extends CardsEvents {
  const GetCollectionsEvent();
}

class RemoveCollectionEvent extends CardsEvents {
  final String uuid;
  const RemoveCollectionEvent({
    required this.uuid,
  });
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
  final String question;
  final String answer;
  const AddFlashcardsEvent({
    required this.collectionUuid,
    required this.question,
    required this.answer,
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

class GetMultipleQuizOptionsEvent extends CardsEvents {
  final FlashcardCollection collection;

  const GetMultipleQuizOptionsEvent({required this.collection});
}

class GenerateFlashcardsEvent extends CardsEvents {
  final File file;
  const GenerateFlashcardsEvent({
    required this.file,
  });
}

class SaveAllGenerateFlashcardsEvent extends CardsEvents {
  final List<Flashcard> flashcards;
  final String collectionUuid;

  const SaveAllGenerateFlashcardsEvent(
      {required this.flashcards, required this.collectionUuid});
}

class CombineCollectionsEvent extends CardsEvents {
  final FlashcardCollection mainCollection;
  final FlashcardCollection secondaryCollection;
  const CombineCollectionsEvent({
    required this.mainCollection,
    required this.secondaryCollection,
  });
}
