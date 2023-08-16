import '../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late Widget reviewScreen;
  late CardsBloc mockBloc;
  final flashcard =
      Flashcard(question: "question", answer: "answer", uuid: '1');
  final flashcard2 =
      Flashcard(question: "question 2", answer: "answer 2", uuid: '2');
  final collection = FlashcardCollection(
      name: "Collection", uuid: "uuid", cards: [flashcard, flashcard2]);
  setUp(() {
    mockBloc = CardsBlocMock();
    reviewScreen = BlocProvider.value(
      value: mockBloc,
      child: MaterialApp(
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          home: ReviewResultScreen(cardAndCollection: (flashcard, collection))),
    );
  });
  group("Test review_result_screen -", () {
    testWidgets(
        "Render review_result_screen, expect two text widgets and 4 review bar",
        (tester) async {
      await tester.pumpWidget(reviewScreen);
      expect(find.text('question'), findsOneWidget);
      expect(find.text("answer"), findsOneWidget);
      expect(find.byType(ReviewBar), findsNWidgets(4));
    });
    testWidgets(
        "when tapping Again option, expect to navigate to [PracticeFlashcardsScreen]",
        (tester) async {
      await tester.pumpWidget(reviewScreen);
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              flashcards: [
                Flashcard(
                  question: "question",
                  answer: "answer",
                )
              ])),
          initialState: const CardsState());
      await tester.tap(find.text('Again'));
      await tester.pumpAndSettle();
      expect(find.byType(PracticeCardsScreen), findsOneWidget);
    });

    testWidgets(
        "when tapping Hard option, expect to navigate to [PracticeFlashcardsScreen]",
        (tester) async {
      await tester.pumpWidget(reviewScreen);
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              flashcards: [
                Flashcard(
                  question: "question",
                  answer: "answer",
                )
              ])),
          initialState: const CardsState());
      await tester.tap(find.text('Hard'));
      await tester.pumpAndSettle();
      expect(find.byType(PracticeCardsScreen), findsOneWidget);
    });

    testWidgets(
        "when tapping Good option, expect to navigate to [PracticeFlashcardsScreen]",
        (tester) async {
      await tester.pumpWidget(reviewScreen);
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              flashcards: [
                Flashcard(
                  question: "question",
                  answer: "answer",
                )
              ])),
          initialState: const CardsState());
      await tester.tap(find.text('Good'));
      await tester.pumpAndSettle();
      expect(find.byType(PracticeCardsScreen), findsOneWidget);
    });

    testWidgets(
        "when tapping Easy option, expect to navigate to [PracticeFlashcardsScreen]",
        (tester) async {
      await tester.pumpWidget(reviewScreen);
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              flashcardRequestState: RequestState.success,
              collectionsRequestState: RequestState.success,
              flashcards: [
                Flashcard(
                  question: "question",
                  answer: "answer",
                )
              ])),
          initialState: const CardsState());
      await tester.tap(find.text('Easy'));
      await tester.pumpAndSettle();
      expect(find.byType(PracticeCardsScreen), findsOneWidget);
    });
  });
}
