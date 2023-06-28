import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

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
                  ? TextButton(
                      onPressed: () => Navigator.of(context).pushNamed('/'),
                      child: const Text("Noting's Here, Go to Home"))
                  : PageView.builder(
                      itemCount: state.flashcards.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () => Navigator.of(context)
                                .pushNamed('/review_result', arguments: (
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
