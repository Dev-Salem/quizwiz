import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class GeneratedFlashcardsScreen extends StatelessWidget {
  final String collectionUuid;
  const GeneratedFlashcardsScreen({super.key, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        switch (state.flashcardRequestState) {
          case RequestState.loading:
            return const LoadingWidget(
              message: "Making Flashcards...",
            );
          case RequestState.error:
            return CustomErrorWidget(
              errorMessage: state.flashcardErrorMessage,
            );
          case RequestState.success:
            return GeneratedFlashcardWidget(
              flashcards: state.flashcards,
              collectionUuid: collectionUuid,
            );
        }
      },
    );
  }
}
