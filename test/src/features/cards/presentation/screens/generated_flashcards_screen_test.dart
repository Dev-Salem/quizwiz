import '../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late CardsBloc mockBloc = CardsBlocMock();
  late Widget generatedFlashcards;
  setUp(() {
    mockBloc = CardsBlocMock();
    generatedFlashcards = BlocProvider.value(
      value: mockBloc,
      child: MaterialApp(
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          home: const GeneratedFlashcardsScreen(
            collectionUuid: '',
          )),
    );
  });
  group(
      "Test generated_flashcards_screen when it's loading, loaded and has error - ",
      () {
    testWidgets(
        "when [flashcardsRequestState] is loading, expect LoadingWidget",
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsNothing);
    });
    testWidgets(
        "when [flashcardsRequestState] is success (loaded), expect loading then a list of [GeneratedFlashcardWidget] (One Card)",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              flashcards: [Flashcard()])),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(GeneratedFlashcardWidget), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        "when [flashcardsRequestState] is success (loaded), expect loading then no [Card](an empty [ListView])",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(const CardsState(
              flashcardRequestState: RequestState.success, flashcards: [])),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(Card), findsNothing);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        "when [flashcardsRequestState] has error, expect loading then [CustomErrorWidget]",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(const CardsState(
              flashcardRequestState: RequestState.error,
              flashcardErrorMessage: "Some Error")),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(CustomErrorWidget), findsOneWidget);
      expect(find.byType(Card), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    testWidgets(
        "When tapping a [FloatingActionButton], expect to save all cards, show loading, then navigating to [FlashcardsListScreen]",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "name", uuid: "")],
              flashcards: [Flashcard()])),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(FlashcardsListScreen), findsOneWidget);
    });

    testWidgets("When tapping done button, navigate to [FlashcardsListScreen]",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "name", uuid: "")],
              flashcards: [Flashcard()])),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      expect(find.byType(FlashcardsListScreen), findsOneWidget);
    });

    testWidgets("When tapping add button, add flashcard and show [Snackbar]",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "name", uuid: "")],
              flashcards: [Flashcard()])),
          initialState: const CardsState());
      await tester.pumpWidget(generatedFlashcards);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      await tester.tap(find.byKey(const Key('0')));
      await tester.pump();
      expect(
          find.widgetWithText(SnackBar, "Flashcard Was Added"), findsOneWidget);
    });
  });
}
