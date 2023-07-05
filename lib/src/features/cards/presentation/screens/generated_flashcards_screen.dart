import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class GeneratedFlashcardsScreen extends StatelessWidget {
  final FlashcardCollection collection;
  const GeneratedFlashcardsScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generated Flashcards"),
      ),
    );
  }
}
