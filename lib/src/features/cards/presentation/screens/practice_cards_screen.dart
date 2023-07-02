import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/practice_cards_widgets/no_flashcards_to_review.dart';

class PracticeCardsScreen extends StatelessWidget {
  final FlashcardCollection collection;
  const PracticeCardsScreen({super.key, required this.collection});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed('/');
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Review Flashcards"),
          ),
          body: BlocBuilder<CardsBloc, CardsState>(
            builder: (context, state) {
              return state.flashcards.isEmpty
                  ? NoFlashcardsToReview(
                      collection: collection,
                    )
                  : PageView.builder(
                      itemCount: state.flashcards.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                RouterConstance.goToReviewResult,
                                arguments: (
                                  state.flashcards[index],
                                  collection
                                )),
                            child: Center(
                              child: Text(
                                state.flashcards[index].question,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ));
            },
          )),
    );
  }
}
