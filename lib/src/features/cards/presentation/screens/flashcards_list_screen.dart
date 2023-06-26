import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/flashcards_list_widgets/flashcard_widget.dart';

class FlashcardsListScreen extends StatelessWidget {
  final FlashcardCollection collection;
  const FlashcardsListScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(collection.name),
        ),
        body: MasonryGridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: collection.cards.length,
            itemBuilder: (context, index) {
              return FlashcardWidget(card: collection.cards[index]);
            }));
  }
}
