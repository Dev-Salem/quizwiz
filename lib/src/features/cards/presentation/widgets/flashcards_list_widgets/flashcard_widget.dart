import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard card;
  const FlashcardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(card.answer),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'review due: ${Jiffy.parseFromDateTime(DateTime.fromMillisecondsSinceEpoch(card.dueTime)).MEd}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          ],
        ),
      ),
    );
  }
}
