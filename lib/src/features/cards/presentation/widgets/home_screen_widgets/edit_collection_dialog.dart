import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class EditCollectionDialog extends StatefulWidget {
  final FlashcardCollection collection;
  const EditCollectionDialog({super.key, required this.collection});

  @override
  State<EditCollectionDialog> createState() => _EditCollectionDialogState();
}

class _EditCollectionDialogState extends State<EditCollectionDialog> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.collection.name);
    descriptionController =
        TextEditingController(text: widget.collection.description);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CreateOrEditCollectionDialog(
      nameController: nameController,
      descriptionController: descriptionController,
      button: TextButton(
          onPressed: () {
            context.read<CardsBloc>().add(EditCollectionEvent(
                collection: widget.collection,
                name: nameController.text.isEmpty
                    ? AppStrings.defaultCollectionName
                    : nameController.text,
                description: descriptionController.text));
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.create)),
    );
  }
}
