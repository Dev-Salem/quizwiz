// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class NoFlashcardsToReview extends StatelessWidget {
  final FlashcardCollection collection;
  const NoFlashcardsToReview({
    Key? key,
    required this.collection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/');
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          const Text(AppStrings.noFlashcardsToReview),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: const Text(AppStrings.goBack)),
                const Expanded(child: SizedBox()),
                FilledButton.icon(
                    onPressed: () {
                      if (collection.cards.length < 4) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Add At Least 4 Flashcards")));
                        Navigator.of(context).pushReplacementNamed('/');
                      } else {
                        context.read<CardsBloc>().add(
                            GetMultipleQuizOptionsEvent(
                                collection: collection));
                        Navigator.of(context).pushNamed(
                          RouterConstance.goToQuiz,
                        );
                      }
                    },
                    icon: const Icon(Icons.quiz),
                    label: const Text(AppStrings.practice)),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
