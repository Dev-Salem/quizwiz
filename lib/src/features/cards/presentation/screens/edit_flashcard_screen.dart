import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class EditFlashcardScreen extends StatefulWidget {
  final EditFlashcardParameters parameters;
  const EditFlashcardScreen({super.key, required this.parameters});

  @override
  State<EditFlashcardScreen> createState() => _EditFlashcardScreenState();
}

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  late final TextEditingController questionController;
  late final TextEditingController answerController;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    questionController =
        TextEditingController(text: widget.parameters.question);
    answerController = TextEditingController(text: widget.parameters.answer);
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  bool _editFlashcard() {
    if (key.currentState!.validate()) {
      context.read<CardsBloc>().add(EditFlashcardsEvent(
          parameters: widget.parameters.copyWith(
              question: questionController.text,
              answer: answerController.text)));
      return true; //if card was added successfully, return true to navigate
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.editFlashcard),
        ),
        body: LayoutBuilder(
            builder: (context, size) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(
                      height: size.maxHeight * 0.2,
                    ),
                    CustomForms(
                        questionController: questionController,
                        answerController: answerController,
                        formKey: key),
                    SizedBox(height: size.maxHeight * 0.2),
                    FilledButton(
                        key: const Key(AppStrings.editFlashcard),
                        onPressed: () {
                          if (_editFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.flashcardsList,
                                arguments: widget.parameters.collection.uuid);
                          }
                        },
                        child: const Text(AppStrings.editFlashcard)),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )));
  }
}
