import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class PastMaterialWidget extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  final String collectionUuid;
  const PastMaterialWidget(
      {Key? key,
      required this.controller,
      required this.collectionUuid,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              minLines: 1,
              maxLines: 3,
              validator: (value) => value!.isEmpty ? "Empty Value" : null,
              decoration:
                  const InputDecoration(label: Text(AppStrings.pasteMaterial)),
            ),
          ),
        ),
        ElevatedButton.icon(
            onPressed: () async {
              if (formKey.currentState!.validate() == true) {
                context
                    .read<CardsBloc>()
                    .add(GenerateFlashcardsEvent(material: controller.text));
                Navigator.of(context).pushReplacementNamed(
                    Routes.generatedFlashcards,
                    arguments: collectionUuid);
              }
            },
            icon: const Icon(Icons.rocket),
            label: const Text(AppStrings.generate))
      ],
    );
  }
}
