import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/core/widgets/loading_widget.dart';
import 'package:quizwiz/src/core/widgets/no_collection_screen.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/flashcards_list_widgets/flashcard_widget.dart';

class FlashcardsListScreen extends StatelessWidget {
  final String collectionUuid;
  const FlashcardsListScreen({super.key, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      buildWhen: (previous, current) =>
          current.collection!.cards != previous.collection!.cards,
      builder: (context, state) {
        switch (state.collectionRequestState) {
          case RequestState.loading:
            return const LoadingWidget();
          case RequestState.error:
            return CustomErrorWidget(
              errorMessage: state.flashcardErrorMessage,
            );
          case RequestState.success:
            final collection = state.collection!;
            return Scaffold(
                appBar: AppBar(
                  title: Text(collection.name),
                ),
                body: collection.cards.isEmpty
                    ? const NoResultScreen(description: AppStrings.noCards)
                    : MasonryGridView.builder(
                        padding: const EdgeInsets.all(15),
                        gridDelegate:
                            const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: collection.cards.length,
                        itemBuilder: (context, index) {
                          return FocusedMenuHolder(
                              menuBoxDecoration:
                                  const BoxDecoration(color: Colors.black),
                              onPressed: () {},
                              menuItems: [
                                FocusedMenuItem(
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    title: const Text(
                                      AppStrings.delete,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      context.read<CardsBloc>().add(
                                          RemoveFlashcardsEvent(
                                              collection: collection,
                                              flashcardUuid: collection
                                                  .cards[index].uuid));
                                    }),
                                FocusedMenuItem(
                                    backgroundColor:
                                        Theme.of(context).cardColor,
                                    title: const Text("Edit"),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              RouterConstance.goToEditFlashcard,
                                              arguments:
                                                  EditFlashcardParameters(
                                                      front: collection
                                                          .cards[index]
                                                          .question,
                                                      back: collection
                                                          .cards[index].answer,
                                                      collection: collection,
                                                      flashcard: collection
                                                          .cards[index]));
                                    })
                              ],
                              child: FlashcardWidget(
                                  card: collection.cards[index]));
                        }));
        }
      },
    );
  }
}
