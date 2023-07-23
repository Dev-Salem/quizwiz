// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
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
            return Scaffold(
                appBar: AppBar(
                  title: Text(collection.name),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                      Routes.goToCreateFlashcards,
                      arguments: collectionUuid),
                  child: const Icon(Icons.add),
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
                          return CustomFocusedMenuHolder(
                              collection: collection,
                              index: index,
                              child: FlashcardWidget(
                                  card: collection.cards[index]));
                        }));
        }
      },
    );
  }
}
