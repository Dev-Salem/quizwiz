import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class CreateCollectionDialog extends StatefulWidget {
  const CreateCollectionDialog({super.key});

  @override
  State<CreateCollectionDialog> createState() => _CreateCollectionDialogState();
}

class _CreateCollectionDialogState extends State<CreateCollectionDialog> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
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
          key: const Key(AppStrings.create),
          onPressed: () {
            context.read<CardsBloc>().add(CreateCollectionsEvent(
                //if the user didn't enter a collection name, assign 'untitled'
                //to the collection name
                name: nameController.text == ''
                    ? AppStrings.defaultCollectionName
                    : nameController.text,
                description: descriptionController.text));
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.create)),
    );
  }
}
