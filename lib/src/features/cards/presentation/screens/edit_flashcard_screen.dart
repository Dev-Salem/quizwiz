import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/models/edit_flashcard_parameters.dart';

class EditFlashcardScreen extends StatefulWidget {
  final EditFlashcardParameters parameters;
  const EditFlashcardScreen({super.key, required this.parameters});

  @override
  State<EditFlashcardScreen> createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  late final TextEditingController frontController;
  late final TextEditingController backController;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    frontController = TextEditingController(text: widget.parameters.front);
    backController = TextEditingController(text: widget.parameters.back);
    super.initState();
  }

  @override
  void dispose() {
    frontController.dispose();
    backController.dispose();
    super.dispose();
  }

  bool _editFlashcard() {
    if (key.currentState!.validate()) {
      context.read<CardsBloc>().add(EditFlashcardsEvent(
          parameters: widget.parameters.copyWith(
              front: frontController.text, back: backController.text)));
      return true; //if card was added successfully, return true to navigate
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Flashcard"),
        ),
        body: LayoutBuilder(
            builder: (context, size) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(
                      height: size.maxHeight * 0.2,
                    ),
                    Form(
                      key: key,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: frontController,
                            maxLines: 2,
                            minLines: 1,
                            validator: (value) => value!.isEmpty
                                ? "Invalid Input: Empty Field"
                                : null,
                            decoration: const InputDecoration(
                              label: Text("Term (Front)"),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            maxLines: 4,
                            minLines: 1,
                            controller: backController,
                            validator: (value) => value!.isEmpty
                                ? "Invalid Input: Empty Field"
                                : null,
                            decoration: const InputDecoration(
                              label: Text("Definition (Back)"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.maxHeight * 0.2),
                    FilledButton(
                        onPressed: () {
                          if (_editFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                '/flashcards_list',
                                arguments: widget.parameters.collection.uuid);
                          }
                        },
                        child: const Text("Edit Card")),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )));
  }
}
