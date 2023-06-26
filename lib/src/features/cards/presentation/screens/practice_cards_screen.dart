import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class PracticeCardsScreen extends StatelessWidget {
  final List<Flashcard> cards;
  const PracticeCardsScreen({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Review Flashcards"),
        ),
        body: PageView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) => Text(cards[index].question)));
  }
}
