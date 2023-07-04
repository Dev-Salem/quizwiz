// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizwiz/src/features/cards/data/data.dart';

class FlashcardsModel {
  List<Flashcard> flashcards;

  FlashcardsModel({
    required this.flashcards,
  });

  factory FlashcardsModel.fromJson(Map<String, dynamic> json) {
    return FlashcardsModel(
        flashcards: List<Flashcard>.from(
            json['text'].map((x) => Flashcard.fromMap(x))));
  }

  @override
  String toString() => 'FlashcardsModel(flashcards: $flashcards)';
}
