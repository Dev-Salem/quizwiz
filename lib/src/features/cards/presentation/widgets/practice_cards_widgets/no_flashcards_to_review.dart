// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/practice_cards_widgets/choose_quiz_dialog.dart';

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
          LottieBuilder.asset(AppStrings.completedTaskAsset),
          Text(
            AppStrings.noFlashcardsToReview,
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
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
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => ChooseQuizDialog(
                              collection: collection,
                            )),
                    icon: const Icon(Icons.quiz),
                    label: const Text(AppStrings.practice)),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
