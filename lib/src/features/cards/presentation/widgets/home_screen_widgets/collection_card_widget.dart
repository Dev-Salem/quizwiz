import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';

class CollectionCardWidget extends StatelessWidget {
  final FlashcardCollection collection;
  const CollectionCardWidget({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //height: 150,
        margin: const EdgeInsets.only(left: 10, top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              collection.name,
              style: Theme.of(context).textTheme.headlineLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              collection.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text("${collection.cards.length}  cards"),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: () {}, child: const Text('Practice')),
                  FilledButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/create_flashcards'),
                      child: const Text("Add Cards"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}