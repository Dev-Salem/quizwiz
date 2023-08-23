// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class FlashcardsListScreen extends StatelessWidget {
  final String collectionUuid;
  const FlashcardsListScreen({super.key, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      buildWhen: (previous, current) =>
          current.collections != previous.collections,
      builder: (context, state) {
        switch (state.collectionsRequestState) {
          case RequestState.loading:
            return const LoadingWidget();
          case RequestState.error:
            return CustomErrorWidget(
              errorMessage: state.flashcardErrorMessage,
            );
          case RequestState.success:
            final collection = state.collections
                .where(
                  (element) => element.uuid == collectionUuid,
                )
                .single;
            //place recent cards at the top
            List<Flashcard> flashcards = collection.cards.reversed.toList();
            return WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pushReplacementNamed('/');
                return true;
              },
              child: Scaffold(
                  appBar: AppBar(
                    title: Text(collection.name),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                        Routes.createFlashcards,
                        arguments: collectionUuid),
                    child: const Icon(Icons.add),
                  ),
                  body: flashcards.isEmpty
                      ? const NoResultScreen(description: AppStrings.noCards)
                      : MasonryGridView.builder(
                          padding: const EdgeInsets.all(15),
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: flashcards.length,
                          itemBuilder: (context, index) {
                            return CustomFocusedMenuHolder(
                                collection: collection,
                                index: index,
                                child:
                                    FlashcardWidget(card: flashcards[index]));
                          })),
            );
        }
      },
    );
  }
}
