import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class CustomFocusedMenuHolder extends StatelessWidget {
  final Widget child;
  final FlashcardCollection collection;
  final int index;
  const CustomFocusedMenuHolder({
    Key? key,
    required this.collection,
    required this.index,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
        menuBoxDecoration: const BoxDecoration(color: Colors.black),
        onPressed: () {},
        menuItems: [
          FocusedMenuItem(
              backgroundColor: Theme.of(context).cardColor,
              title: const Text(
                AppStrings.delete,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                context.read<CardsBloc>().add(RemoveFlashcardsEvent(
                    collection: collection,
                    flashcardUuid: collection.cards[index].uuid));
              }),
          FocusedMenuItem(
              backgroundColor: Theme.of(context).cardColor,
              title: const Text(AppStrings.edit),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.editFlashcard,
                    arguments: EditFlashcardParameters(
                        question: collection.cards[index].question,
                        answer: collection.cards[index].answer,
                        collection: collection,
                        flashcard: collection.cards[index]));
              })
        ],
        child: child);
  }
}
