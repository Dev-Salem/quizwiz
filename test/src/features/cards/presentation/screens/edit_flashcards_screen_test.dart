import '../../../../tests_imports.dart';

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
                question: "question",
                answer: "answer",
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
      var questionTextFormField = find.byKey(const Key("question"));
      var answerTextFormField = find.byKey(const Key("answer"));
      await tester.enterText(questionTextFormField, "Question");
      await tester.enterText(answerTextFormField, "Answer");
      var customFormsFinder =
          tester.widget<CustomForms>(find.byType(CustomForms));
      expect(customFormsFinder.questionController.text, "Question");
      expect(customFormsFinder.answerController.text, "Answer");
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
      var questionTextFormField = find.byKey(const Key("question"));
      var answerTextFormField = find.byKey(const Key("answer"));
      await tester.enterText(questionTextFormField, "Edited");
      await tester.enterText(answerTextFormField, "Edited");
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
