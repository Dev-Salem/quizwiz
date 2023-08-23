// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:focused_menu/modals.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/home_screen_widgets/combine_collection_dialog.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/home_screen_widgets/edit_collection_dialog.dart';

class CollectionsListScreen extends StatelessWidget {
  final List<FlashcardCollection> collections;
  const CollectionsListScreen({super.key, required this.collections});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      itemCount: collections.length,
      itemBuilder: (listViewContext, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10 // 10,
              ),
          child: FocusedMenuHolder(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.flashcardsList,
                  arguments: collections[index].uuid);
            },
            menuItems: [
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).cardColor,
                  title: const Text(
                    AppStrings.delete,
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    context.read<CardsBloc>().add(
                        RemoveCollectionEvent(uuid: collections[index].uuid));
                  }),
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).cardColor,
                  title: const Text(
                    AppStrings.edit,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (context) => EditCollectionDialog(
                          collection: collections[index]))),
              FocusedMenuItem(
                  backgroundColor: Theme.of(context).cardColor,
                  title: const Text(
                    AppStrings.combineCollection,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      useRootNavigator: false,
                      builder: (_) {
                        return CombineCollectionDialog(
                          //the selected collection
                          mainCollection: collections[index],
                          //the available collections to combine with
                          availableCollection: collections
                              .where((element) => element != collections[index])
                              .toList(),
                        );
                      })),
            ],
            child: CollectionCardWidget(
              collection: collections[index],
            ),
          )),
    );
  }
}
