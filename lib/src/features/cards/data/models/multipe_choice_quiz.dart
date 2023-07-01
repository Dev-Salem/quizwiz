// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:quizwiz/src/features/cards/data/data.dart';

class MultipleChoiceQuiz {
  final String question;
  final List<String> options;
  final String rightAnswer;
  const MultipleChoiceQuiz({
    required this.question,
    required this.options,
    required this.rightAnswer,
  });
  //takes a collection and a card and generates multiple choice quiz question
  factory MultipleChoiceQuiz.fromCollection(
      {required card, required FlashcardCollection collection}) {
    //insert the right answer into `options`
    List<String> options = [card.answer];
    var random = Random();
    //pick 3 unique and random answers from the collection
    while (options.length < 4) {
      int randomElement = random.nextInt(collection.cards.length);
      if (!options.contains(collection.cards[randomElement].answer)) {
        options.add(collection.cards[randomElement].answer);
      }
    }
    //shuffle the options
    options.shuffle();
    return MultipleChoiceQuiz(
        question: card.question, options: options, rightAnswer: card.answer);
  }
}
