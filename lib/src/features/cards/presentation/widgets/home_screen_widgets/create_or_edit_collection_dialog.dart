// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quizwiz/src/core/core.dart';

class CreateOrEditCollectionDialog extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextButton button;
  const CreateOrEditCollectionDialog({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.button,
  }) : super(key: key);

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
        button
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
