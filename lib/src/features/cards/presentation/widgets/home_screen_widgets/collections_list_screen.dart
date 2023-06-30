// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:quizwiz/src/core/utils/strings.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class CollectionsListScreen extends StatelessWidget {
  final List<FlashcardCollection> collections;
  const CollectionsListScreen({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      itemCount: collections.length,
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10 // 10,
              ),
          child: FocusedMenuHolder(
            onPressed: () => Navigator.of(context).pushNamed('/flashcards_list',
                arguments: collections[index].uuid),
            menuItems: [
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).cardColor,
                  title: const Text(
                    AppStrings.delete,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    context.read<CardsBloc>().add(
                        RemoveCollectionEvent(uuid: collections[index].uuid));
                  }),
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).cardColor,
                  title: const Text(
                    "Edit",
                  ),
                  onPressed: () {}),
            ],
            child: CollectionCardWidget(
              collection: collections[index],
            ),
          )),
    );
  }
}
