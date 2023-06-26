import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/flashcards_list_widgets/flashcard_widget.dart';

class FlashcardsListScreen extends StatelessWidget {
  final String collectionUuid;
  const FlashcardsListScreen({super.key, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CollectionState>(
      builder: (context, state) {
        final collection = state.collections
            .where((collection) => collection.uuid == collectionUuid)
            .single;
        return Scaffold(
            appBar: AppBar(
              title: Text(collection.name),
            ),
            body: MasonryGridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: collection.cards.length,
                itemBuilder: (context, index) {
                  return FocusedMenuHolder(
                      onPressed: () {},
                      menuItems: [
                        FocusedMenuItem(
                            backgroundColor: Theme.of(context).cardColor,
                            title: const Text(
                              AppStrings.delete,
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () => context.read<CardsBloc>().add(
                                RemoveFlashcardsEvent(
                                    collection: collection,
                                    flashcardUuid:
                                        collection.cards[index].uuid)))
                      ],
                      child: FlashcardWidget(card: collection.cards[index]));
                }));
      },
    );
  }
}
