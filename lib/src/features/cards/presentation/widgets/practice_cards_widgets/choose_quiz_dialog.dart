// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class ChooseQuizDialog extends StatelessWidget {
  final FlashcardCollection collection;
  const ChooseQuizDialog({
    Key? key,
    required this.collection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(AppStrings.quizType),
      alignment: Alignment.center,
      contentPadding: const EdgeInsets.all(25),
      children: [
        Column(
          children: [
            CustomListTile(
                text: AppStrings.multipleChoice,
                icon: Icons.quiz,
                onPressed: () {
                  if (collection.cards.length < 4) {
                    customSnackBar("Add At Least 4 Flashcards", context);
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    context.read<CardsBloc>().add(
                        GetMultipleQuizOptionsEvent(collection: collection));
                    Navigator.of(context).pushNamed(
                      Routes.quiz,
                    );
                  }
                }),
            CustomListTile(
                text: AppStrings.writingQuiz,
                icon: Icons.edit,
                onPressed: () {
                  var shuffledCards = [...collection.cards];
                  shuffledCards.shuffle();
                  Navigator.of(context)
                      .pushNamed(Routes.writingQuiz, arguments: shuffledCards);
                }),
          ],
        )
      ],
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onPressed;
  const CustomListTile({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }
}
