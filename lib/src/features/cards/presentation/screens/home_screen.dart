import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.homeScreen),
              actions: [
                IconButton(
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                    icon: const Icon(Icons.dark_mode))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const CreateCollectionDialog()),
              child: const Icon(Icons.add),
            ),
            body: BlocBuilder<CardsBloc, CardsState>(
              builder: (context, state) {
                switch (state.collectionsRequestState) {
                  case RequestState.loading:
                    return const LoadingWidget();
                  case RequestState.error:
                    return CustomErrorWidget(
                      errorMessage: state.flashcardErrorMessage,
                    );
                  case RequestState.success:
                    return state.collections.isEmpty
                        ? const NoResultScreen(
                            description: AppStrings.noCollection)
                        : CollectionsListScreen(collections: state.collections);
                }
              },
            )));
  }
}
