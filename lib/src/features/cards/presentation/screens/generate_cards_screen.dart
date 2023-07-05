import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';

class GenerateCardsScreen extends StatefulWidget {
  final String collectionUuid;
  const GenerateCardsScreen({super.key, required this.collectionUuid});

  @override
  State<GenerateCardsScreen> createState() => _GenerateCardsScreenState();
}

class _GenerateCardsScreenState extends State<GenerateCardsScreen> {
  late final TextEditingController _controller;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: _controller,
                minLines: 1,
                maxLines: 10,
                validator: (value) => value!.isEmpty ? "Empty Value" : null,
                decoration: const InputDecoration(
                    label: Text(AppStrings.pasteMaterial)),
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                if (formKey.currentState!.validate() == true) {
                  Navigator.of(context).pushReplacementNamed(
                      RouterConstance.goToGeneratedFlashcards,
                      arguments: widget.collectionUuid);
                }
              },
              icon: const Icon(Icons.rocket),
              label: const Text(AppStrings.generate))
        ],
      ),
    );
  }
}
