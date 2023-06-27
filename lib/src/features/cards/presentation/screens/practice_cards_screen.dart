import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class PracticeCardsScreen extends StatelessWidget {
  final FlashcardCollection collection;
  const PracticeCardsScreen({super.key, required this.collection});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Review Flashcards"),
        ),
        body: PageView.builder(
            itemCount: collection.cards.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                      '/review_result',
                      arguments: (collection.cards[index], collection.uuid)),
                  child: Center(
                    child: Text(
                      collection.cards[index].question,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                )));
  }
}
