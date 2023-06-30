import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class EditCollectionDialog extends StatefulWidget {
  const EditCollectionDialog({super.key});

  @override
  State<EditCollectionDialog> createState() => _EditCollectionDialogState();
}

class _EditCollectionDialogState extends State<EditCollectionDialog> {
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
            onPressed: () {}, child: const Text(AppStrings.createCollection)));
  }
}
