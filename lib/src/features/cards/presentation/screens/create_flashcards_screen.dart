import 'package:flutter/material.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class CreateFlashcardsScreen extends StatefulWidget {
  final String collectionUuid;
  //if cardInfo is empty then add new card, otherwise edit card
  final (String front, String back)? cardInfo;
  final Flashcard? flashcard;
  const CreateFlashcardsScreen(
      {super.key, required this.collectionUuid, this.cardInfo, this.flashcard});

  @override
  State<CreateFlashcardsScreen> createState() => _CreateFlashcardsScreenState();
}

class _CreateFlashcardsScreenState extends State<CreateFlashcardsScreen> {
  late final TextEditingController frontController;
  late final TextEditingController backController;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    frontController = TextEditingController(text: widget.cardInfo?.$1);
    backController = TextEditingController(text: widget.cardInfo?.$2);
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
