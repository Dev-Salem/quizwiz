import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class FlashcardsListScreen extends StatelessWidget {
  final FlashcardCollection collection;
  const FlashcardsListScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: collection.cards.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.7),
          itemBuilder: (context, index) => Card(
                child: Column(
                  children: [
                    Text(
                      collection.cards[index].question,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      collection.cards[index].answer,
                      // style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              )),
    );
  }
}
