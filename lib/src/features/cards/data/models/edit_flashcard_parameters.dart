// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizwiz/src/features/cards/data/data.dart';

class EditFlashcardParameters {
  final String question;
  final String back;
  final FlashcardCollection collection;
  final Flashcard flashcard;
  const EditFlashcardParameters({
    required this.question,
    required this.back,
    required this.collection,
    required this.flashcard,
  });

  EditFlashcardParameters copyWith({
    String? question,
    String? back,
    FlashcardCollection? collection,
    Flashcard? flashcard,
  }) {
    return EditFlashcardParameters(
      question: question ?? this.question,
      back: back ?? this.back,
      collection: collection ?? this.collection,
      flashcard: flashcard ?? this.flashcard,
    );
  }
}
