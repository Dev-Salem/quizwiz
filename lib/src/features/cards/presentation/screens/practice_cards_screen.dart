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
            itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                      '/review_result',
                      arguments: cards[index]),
                  child: Center(
                    child: Text(
                      cards[index].question,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                )));
  }
}
