import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/core/widgets/loading_widget.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/generated_flashcards/generated_flashcard_widget.dart';

class GeneratedFlashcardsScreen extends StatelessWidget {
  final String collectionUuid;
  const GeneratedFlashcardsScreen({super.key, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardsBloc, CardsState>(
      builder: (context, state) {
        switch (state.flashcardRequestState) {
          case RequestState.loading:
            return const LoadingWidget();
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
