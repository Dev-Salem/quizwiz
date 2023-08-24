import '../../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late Widget generatedFlashcard;
  late CardsBloc blocMock;
  final flashcards = [
    Flashcard(question: "question", answer: "answer", uuid: "1"),
    Flashcard(question: "question 2", answer: "answer 2", uuid: "2"),
    Flashcard(question: "question 3", answer: "answer 3", uuid: "3"),
  ];
  setUp(() {
    blocMock = CardsBlocMock();
    generatedFlashcard = BlocProvider.value(
      value: blocMock,
      child: MaterialApp(
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        home: GeneratedFlashcardWidget(
            flashcards: flashcards, collectionUuid: ""),
      ),
    );
    whenListen(
        blocMock,
        Stream.value(CardsState(
            collectionsRequestState: RequestState.success,
            collections: [
              FlashcardCollection(name: "", uuid: "", cards: [
                Flashcard(),
                Flashcard(),
                Flashcard(),
              ])
            ])),
        initialState: const CardsState());
  });

  group("Test [GeneratedFlashcardWidget] -", () {
    testWidgets('''Render [GeneratedFlashcardWidget],
     expect [AppBar], [FloatingActionButton], [TextButton], [ListView], [GeneratedFlashcardCardWidget]''',
        (tester) async {
      await tester.pumpWidget(generatedFlashcard);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(GeneratedFlashcardCardWidget), findsNWidgets(3));
    });
    testWidgets('''Render [GeneratedFlashcardCardWidget], expect three widgets,
        with three different questions and answers''', (tester) async {
      await tester.pumpWidget(generatedFlashcard);
      expect(find.byType(GeneratedFlashcardCardWidget), findsNWidgets(3));
      expect(find.text(flashcards[0].question), findsOneWidget);
      expect(find.text(flashcards[1].question), findsOneWidget);
      expect(find.text(flashcards[2].question), findsOneWidget);
      expect(find.text(flashcards[0].answer), findsOneWidget);
      expect(find.text(flashcards[1].answer), findsOneWidget);
      expect(find.text(flashcards[2].answer), findsOneWidget);
    });
    testWidgets(
        '''When tapping done button, expect to navigate to [FlashcardListScree]''',
        (tester) async {
      await tester.pumpWidget(generatedFlashcard);
      await tester.tap(find.text(AppStrings.done));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(FlashcardsListScreen), findsOneWidget);
      expect(find.byType(FlashcardWidget), findsNWidgets(3));
    });
    testWidgets(
        '''When tapping [FloatingActionButton], expect to navigate to [FlashcardListScree]''',
        (tester) async {
      await tester.pumpWidget(generatedFlashcard);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(FlashcardsListScreen), findsOneWidget);
      expect(find.byType(FlashcardWidget), findsNWidgets(3));
    });
    testWidgets(
        '''When tapping an add button for [GeneratedFlashcardCardWidget],
         expect a [Snackbar] with a text''', (tester) async {
      await tester.pumpWidget(generatedFlashcard);
      await tester.tap(find.byKey(const Key('0')));
      await tester.pump();
      expect(
          find.widgetWithText(SnackBar, "Flashcard Was Added"), findsOneWidget);
    });
  });
}
