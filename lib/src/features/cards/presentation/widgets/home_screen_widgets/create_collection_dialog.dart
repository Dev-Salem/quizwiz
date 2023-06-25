import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/cubit/cards_bloc.dart';
import 'package:quizwiz/src/features/cards/controller/cubit/cards_events.dart';

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
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(AppStrings.createCollection),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              AppStrings.cancel,
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              context.read<CardsBloc>().add(CreateCollectionsEvent(
                  name: nameController.text == ''
                      ? AppStrings.defaultCollectionName
                      : nameController.text,
                  description: descriptionController.text));
              Navigator.of(context).pop();
            },
            child: const Text(AppStrings.create)),
      ],
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              maxLength: 30,
              decoration: const InputDecoration(
                label: Text(AppStrings.nameTextFieldLabel),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              maxLength: 70,
              decoration: const InputDecoration(
                label: Text(AppStrings.descriptionTextFieldLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
