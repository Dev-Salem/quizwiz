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
                    RouterConstance.goToFlashcardsList,
                    arguments: collectionUuid);
              },
              child: const Text(AppStrings.done))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read<CardsBloc>().add(SaveAllGenerateFlashcardsEvent(
                flashcards: flashcards, collectionUuid: collectionUuid));
            Navigator.of(context).pushReplacementNamed('/');
          },
          icon: const Icon(Icons.add),
          label: const Text(AppStrings.addAll)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
          itemCount: flashcards.length,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                              onPressed: () {
                                context.read<CardsBloc>().add(
                                    AddFlashcardsEvent(
                                        collectionUuid: collectionUuid,
                                        front: flashcards[index].question,
                                        back: flashcards[index].answer));
                                customSnackBar("Flashcard Is Added", context);
                              },
                              icon: const Icon(Icons.add))
                        ],
                      ),
                      Text(flashcards[index].answer)
                    ],
                  ),
                ),
              )),
    );
  }
}
