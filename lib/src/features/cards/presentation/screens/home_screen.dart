import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/create_collection_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.homeScreen),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => const CreateCollectionDialog()),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<CardsBloc, CollectionState>(
          builder: (context, state) {
            switch (state.requestState) {
              case RequestState.loading:
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              case RequestState.error:
                return Center(
                  child: Text(state.errorMessage),
                );
              case RequestState.success:
                return state.collections.isEmpty
                    ? const NoCollectionScreen()
                    : CollectionsListScreen(collections: state.collections);
              default:
                return const Text(AppStrings.errorMessage);
            }
          },
        ));
  }
}
