import 'package:flutter/material.dart';

class CustomForms extends StatelessWidget {
  final TextEditingController frontController;
  final TextEditingController backController;
  final GlobalKey<FormState> formKey;
  const CustomForms(
      {super.key,
      required this.frontController,
      required this.backController,
      required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            key: const Key("front"),
            controller: frontController,
            maxLines: 2,
            minLines: 1,
            validator: (value) =>
                value!.isEmpty ? "Invalid Input: Empty Field" : null,
            decoration: const InputDecoration(
              label: Text("Term (Front)"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            key: const Key("back"),
            maxLines: 4,
            minLines: 1,
            controller: backController,
            validator: (value) =>
                value!.isEmpty ? "Invalid Input: Empty Field" : null,
            decoration: const InputDecoration(
              label: Text("Definition (Back)"),
            ),
          ),
        ],
      ),
    );
  }
}
