import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/create_flashcards_widgets/forms.dart';

class CreateFlashcardsScreen extends StatefulWidget {
  final String collectionUuid;
  const CreateFlashcardsScreen({
    super.key,
    required this.collectionUuid,
  });

  @override
  State<CreateFlashcardsScreen> createState() => _CreateFlashcardsScreenState();
}

class _CreateFlashcardsScreenState extends State<CreateFlashcardsScreen> {
  late final TextEditingController frontController;
  late final TextEditingController backController;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    frontController = TextEditingController();
    backController = TextEditingController();
  }

  @override
  void dispose() {
    frontController.dispose();
    backController.dispose();
    super.dispose();
  }

  bool _addFlashcard() {
    if (key.currentState!.validate()) {
      context.read<CardsBloc>().add(AddFlashcardsEvent(
          collectionUuid: widget.collectionUuid,
          front: frontController.text,
          back: backController.text));
      return true; //if card was added successfully, return true to navigate
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.createFlashcards),
        ),
        body: LayoutBuilder(
            builder: (context, size) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(
                      height: size.maxHeight * 0.2,
                    ),
                    CustomForms(
                        formKey: key,
                        frontController: frontController,
                        backController: backController),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              RouterConstance.goToGenerateFlashcards,
                              arguments: widget.collectionUuid);
                        },
                        icon: const Icon(Icons.rocket),
                        label: const Text(AppStrings.generateWithAI)),
                    SizedBox(height: size.maxHeight * 0.2),
                    FilledButton(
                        onPressed: () {
                          if (_addFlashcard()) {
                            Navigator.of(context).pushNamed(
                              '/',
                            );
                          }
                        },
                        child: const Text(AppStrings.addCard)),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                        onPressed: () {
                          if (_addFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                RouterConstance.goToCreateFlashcards,
                                arguments: widget.collectionUuid);
                          }
                        },
                        child: const Text(AppStrings.addAnotherCard)),
                  ],
                )));
  }
}
