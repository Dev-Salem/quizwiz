// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AnswerFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;
  final Function(String) onSubmit;
  const AnswerFormField({
    Key? key,
    required this.controller,
    required this.enabled,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        minLines: 1,
        maxLines: 3,
        enabled: enabled,
        textInputAction: TextInputAction.done,
        onFieldSubmitted: onSubmit,
        autofocus: true,
        decoration: const InputDecoration(labelText: "Definition / Answer"),
      ),
    );
  }
}
