import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class CombineCollectionDialog extends StatelessWidget {
  final FlashcardCollection mainCollection;
  final List<FlashcardCollection> availableCollection;
  const CombineCollectionDialog(
      {super.key,
      required this.mainCollection,
      required this.availableCollection});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(AppStrings.combineWith),
      contentPadding: const EdgeInsets.all(30),
      children: List.generate(availableCollection.length, (index) {
        return InkWell(
          onTap: () {
            context.read<CardsBloc>().add(CombineCollectionsEvent(
                mainCollection: mainCollection,
                secondaryCollection: availableCollection[index]));
            customSnackBar(AppStrings.combineCollectionMessage, context);
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              const Icon(Icons.folder),
              const SizedBox(
                width: 10,
              ),
              Text(availableCollection[index].name)
            ],
          ),
        );
      }),
    );
  }
}
