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
  late final TextEditingController frontController;
  late final TextEditingController backController;
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    frontController = TextEditingController(text: widget.parameters.front);
    backController = TextEditingController(text: widget.parameters.back);
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
                        frontController: frontController,
                        backController: backController,
                        formKey: key),
                    SizedBox(height: size.maxHeight * 0.2),
                    FilledButton(
                        onPressed: () {
                          if (_editFlashcard()) {
                            Navigator.of(context).pushReplacementNamed(
                                Routes.goToFlashcardsList,
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
