// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizwiz/src/features/cards/data/data.dart';

class EditFlashcardParameters {
  final String front;
  final String back;
  final FlashcardCollection collection;
  final Flashcard flashcard;
  const EditFlashcardParameters({
    required this.front,
    required this.back,
    required this.collection,
    required this.flashcard,
  });

  EditFlashcardParameters copyWith({
    String? front,
    String? back,
    FlashcardCollection? collection,
    Flashcard? flashcard,
  }) {
    return EditFlashcardParameters(
      front: front ?? this.front,
      back: back ?? this.back,
      collection: collection ?? this.collection,
      flashcard: flashcard ?? this.flashcard,
    );
  }
}
