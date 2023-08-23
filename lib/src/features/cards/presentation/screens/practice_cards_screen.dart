import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

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
            title: const Text(AppStrings.reviewFlashcard),
          ),
          body: BlocBuilder<CardsBloc, CardsState>(
            builder: (context, state) {
              switch (state.flashcardRequestState) {
                case RequestState.loading:
                  return const LoadingWidget();
                case RequestState.error:
                  return CustomErrorWidget(
                    errorMessage: state.flashcardErrorMessage,
                  );
                case RequestState.success:
                  return state.flashcards.isEmpty
                      ? NoFlashcardsToReview(
                          collection: collection,
                        )
                      : PageView.builder(
                          itemCount: state.flashcards.length,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(Routes.reviewResult, arguments: (
                                  state.flashcards[index],
                                  collection
                                )),
                                child: Center(
                                  child: Text(
                                    state.flashcards[index].question,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ));
              }
            },
          )),
    );
  }
}
