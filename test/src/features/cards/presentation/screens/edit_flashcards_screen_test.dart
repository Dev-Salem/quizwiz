import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late Widget createFlashcardsScreen;
  late CardsBloc blocMock;

  final initialFlashcard =
      Flashcard(question: "question", answer: "answer", uuid: "123");
  final editedFlashcard =
      initialFlashcard.copyWith(question: "Edited", answer: "Edited");
  final collection = FlashcardCollection(
      name: "name", uuid: "uuid", cards: [initialFlashcard]);
  setUp(() {
    blocMock = CardsBlocMock();
    createFlashcardsScreen = BlocProvider.value(
      value: blocMock,
      child: MaterialApp(
        onGenerateRoute: ((settings) => RouteGenerator.generateRoute(settings)),
        home: EditFlashcardScreen(
            parameters: EditFlashcardParameters(
                front: "front",
                back: "back",
                collection: collection,
                flashcard: initialFlashcard)),
      ),
    );
  });
  tearDown(() => blocMock.close());
  group("Test edit_flashcards_screen - ", () {
    testWidgets("Render edit_flashcards_screen", (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      expect(find.byType(CustomForms), findsOneWidget);
      expect(find.byType(FilledButton), findsNWidgets(1));
      expect(find.byType(LayoutBuilder), findsOneWidget);
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('''When entering texts to [TextFormField],
         expect non-null values in [TextEditingController] and true value from the validator''',
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      var frontTextFormField = find.byKey(const Key("front"));
      var backTextFormField = find.byKey(const Key("back"));
      await tester.enterText(frontTextFormField, "Question");
      await tester.enterText(backTextFormField, "Answer");
      var customFormsFinder =
          tester.widget<CustomForms>(find.byType(CustomForms));
      expect(customFormsFinder.frontController.text, "Question");
      expect(customFormsFinder.backController.text, "Answer");
      expect(customFormsFinder.formKey.currentState?.validate(), true);
    });

    testWidgets('''By Default, expect non-null values in [TextFormField]''',
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      var customFormsFinder =
          tester.widget<CustomForms>(find.byType(CustomForms));
      expect(customFormsFinder.formKey.currentState?.validate(), true);
    });

    testWidgets(
        "When Edit button is clicked and the validation is true, expect to navigate to [FlashcardListScreen] ",
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      var frontTextFormField = find.byKey(const Key("front"));
      var backTextFormField = find.byKey(const Key("back"));
      await tester.enterText(frontTextFormField, "Edited");
      await tester.enterText(backTextFormField, "Edited");
      whenListen(
          blocMock,
          Stream.value(CardsState(
              collectionsRequestState: RequestState.success,
              collections: [
                collection.copyWith(cards: [editedFlashcard])
              ])),
          initialState: const CardsState());
      var customFormsFinder =
          tester.widget<CustomForms>(find.byType(CustomForms));
      expect(customFormsFinder.formKey.currentState?.validate(), true);
      await tester.tap(find.byKey(const Key(AppStrings.editFlashcard)));
      await tester.pumpAndSettle();
      expect(find.byType(FlashcardsListScreen), findsOneWidget);
      expect(find.byType(FlashcardWidget), findsOneWidget);
    });
  });
}
