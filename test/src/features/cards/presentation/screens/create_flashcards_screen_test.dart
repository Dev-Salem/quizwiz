import '../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late Widget createFlashcardsScreen;
  late CardsBloc blocMock;
  setUp(() {
    blocMock = CardsBlocMock();
    createFlashcardsScreen = BlocProvider.value(
      value: blocMock,
      child: MaterialApp(
        onGenerateRoute: ((settings) => RouteGenerator.generateRoute(settings)),
        home: const CreateFlashcardsScreen(collectionUuid: ""),
      ),
    );
  });
  tearDown(() => blocMock.close());
  group("Test create_flashcards_screen - ", () {
    testWidgets("Render create_flashcards_screen", (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      expect(find.byType(CustomForms), findsOneWidget);
      expect(find.byKey(const Key(AppStrings.generateWithAI)), findsOneWidget);
      expect(find.byType(FilledButton), findsNWidgets(2));
      expect(find.byType(LayoutBuilder), findsOneWidget);
      expect(find.byType(ListView), findsWidgets);
    });
    testWidgets(
        "When GenerateWithAI button is clicked, expect to navigate to open file picker ",
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      final generateButton = find.byKey(const Key(AppStrings.generateWithAI));
      await tester.tap(generateButton);
      await tester.pumpAndSettle();
      // expect(find.byType(GenerateCardsScreen), findsOneWidget);
    });

    testWidgets('''When entering texts into [TextFormField],
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

    testWidgets('''When leaving [TextFormField] empty,
         expect false from the validator''', (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      var customFormsFinder =
          tester.widget<CustomForms>(find.byType(CustomForms));
      expect(customFormsFinder.formKey.currentState?.validate(), false);
    });

    testWidgets(
        "When AddCard button is clicked and the validation is true, expect to navigate to [FlashcardListScreen] ",
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      var questionTextFormField = find.byKey(const Key("question"));
      var answerTextFormField = find.byKey(const Key("answer"));
      await tester.enterText(questionTextFormField, "Question");
      await tester.enterText(answerTextFormField, "Answer");
      await tester.tap(find.byKey(const Key(AppStrings.addCard)));
      whenListen(
          blocMock,
          Stream.value(CardsState(
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "", uuid: "")])),
          initialState: const CardsState());
      await tester.pumpAndSettle();
      expect(find.byType(FlashcardsListScreen), findsOneWidget);
    });

    testWidgets(
        "When AddAnotherCard button is clicked and the validation is true, expect to push [CreateFlashcardScreen] ",
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      var questionTextFormField = find.byKey(const Key("question"));
      var answerTextFormField = find.byKey(const Key("answer"));
      await tester.enterText(questionTextFormField, "Question");
      await tester.enterText(answerTextFormField, "Answer");
      await tester.tap(find.byKey(const Key(AppStrings.addAnotherCard)));
      whenListen(
          blocMock,
          Stream.value(CardsState(
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "", uuid: "")])),
          initialState: const CardsState());
      await tester.pumpAndSettle();
      expect(find.byType(CreateFlashcardsScreen), findsOneWidget);
    });
  });
}
