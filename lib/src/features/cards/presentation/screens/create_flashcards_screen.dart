import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data_source/remote_data_source.dart';
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
    frontController = TextEditingController();
    backController = TextEditingController();
    super.initState();
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
          title: const Text("Create Flashcards"),
        ),
        body: LayoutBuilder(
            builder: (context, size) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(
                      height: size.maxHeight * 0.2,
                    ),
                    SizedBox(
                      width: 50,
                      child: TextButton.icon(
                          onPressed: () async {
                            await DioLocalDataSource().generateFlashcards(
                                """Michael Feathers, author of Working
Effectively with Legacy Code
I could list all of the qualities that I notice in clean code, but there is one overarching quality that leads to all of them. Clean code always looks like it was written by someone who cares. There is nothing obvious that you can do to make it better. All of those things were thought about by the code’s author, and if you try to imagine improvements, you’re led back to where you are, sitting in appreciation of the code someone left for you—code left by some- one who cares deeply about the craft. """);
                          },
                          icon: const Icon(Icons.rocket),
                          label: const Text(
                            "Generate Cards With AI",
                          )),
                    ),
                    CustomForms(
                        formKey: key,
                        frontController: frontController,
                        backController: backController),
                    SizedBox(height: size.maxHeight * 0.2),
                    FilledButton(
                        onPressed: () {
                          if (_addFlashcard()) {
                            Navigator.of(context).pushNamed(
                              '/',
                            );
                          }
                        },
                        child: const Text("Add Card")),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                        onPressed: () {
                          if (_addFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                '/create_flashcards',
                                arguments: widget.collectionUuid);
                          }
                        },
                        child: const Text("Add Another Card")),
                  ],
                )));
  }
}
