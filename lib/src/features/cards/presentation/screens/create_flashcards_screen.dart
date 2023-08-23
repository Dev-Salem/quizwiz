import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

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
  late final TextEditingController questionController;
  late final TextEditingController answerController;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    questionController = TextEditingController();
    answerController = TextEditingController();
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  bool _addFlashcard() {
    if (key.currentState!.validate()) {
      context.read<CardsBloc>().add(AddFlashcardsEvent(
          collectionUuid: widget.collectionUuid,
          question: questionController.text,
          answer: answerController.text));
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
                        questionController: questionController,
                        answerController: answerController),
                    TextButton.icon(
                        key: const Key(AppStrings.generateWithAI),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              Routes.generateFlashcards,
                              arguments: widget.collectionUuid);
                        },
                        icon: const Icon(Icons.rocket),
                        label: const Text(AppStrings.generateWithAI)),
                    SizedBox(height: size.maxHeight * 0.2),
                    FilledButton(
                        key: const Key(AppStrings.addCard),
                        onPressed: () {
                          if (_addFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.flashcardsList,
                                arguments: widget.collectionUuid);
                          }
                        },
                        child: const Text(AppStrings.addCard)),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                        key: const Key(AppStrings.addAnotherCard),
                        onPressed: () {
                          if (_addFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.createFlashcards,
                                arguments: widget.collectionUuid);
                          }
                        },
                        child: const Text(AppStrings.addAnotherCard)),
                  ],
                )));
  }
}
