import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/core/widgets/loading_widget.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';

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
            return Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.generatedFlashcard),
                actions: [
                  TextButton(
                      onPressed: () {}, child: const Text(AppStrings.done))
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text(AppStrings.addAll)),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body: ListView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  itemBuilder: (context, index) => Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text("",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add))
                                ],
                              ),
                              const Text('')
                            ],
                          ),
                        ),
                      )),
            );
        }
      },
    );
  }
}
