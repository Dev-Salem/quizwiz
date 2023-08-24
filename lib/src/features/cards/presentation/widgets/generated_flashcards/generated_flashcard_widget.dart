// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class GeneratedFlashcardWidget extends StatelessWidget {
  final List<Flashcard> flashcards;
  final String collectionUuid;
  const GeneratedFlashcardWidget(
      {super.key, required this.flashcards, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.generatedFlashcard),
        actions: [
          TextButton(
              key: key,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(
                    Routes.flashcardsList,
                    arguments: collectionUuid);
              },
              child: const Text(AppStrings.done))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<CardsBloc>().add(SaveAllGenerateFlashcardsEvent(
                flashcards: flashcards, collectionUuid: collectionUuid));
            Navigator.of(context).pushReplacementNamed(Routes.flashcardsList,
                arguments: collectionUuid);
          },
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.addAll)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
          itemCount: flashcards.length,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          itemBuilder: (context, index) => GeneratedFlashcardCardWidget(
              flashcards: flashcards,
              index: index,
              collectionUuid: collectionUuid)),
    );
  }
}

class GeneratedFlashcardCardWidget extends StatelessWidget {
  final List<Flashcard> flashcards;
  final int index;
  final String collectionUuid;
  const GeneratedFlashcardCardWidget({
    Key? key,
    required this.flashcards,
    required this.index,
    required this.collectionUuid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(flashcards[index].question,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                IconButton(
                    key: Key("$index"),
                    onPressed: () {
                      context.read<CardsBloc>().add(AddFlashcardsEvent(
                          collectionUuid: collectionUuid,
                          question: flashcards[index].question,
                          answer: flashcards[index].answer));
                      customSnackBar("Flashcard Was Added", context);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            Text(flashcards[index].answer)
          ],
        ),
      ),
    );
  }
}
