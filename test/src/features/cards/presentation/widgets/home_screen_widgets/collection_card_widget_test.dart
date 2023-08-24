import '../../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late Widget collectionCardWidget;
  late CardsBloc mockBloc;

  setUp(() {
    mockBloc = CardsBlocMock();
    return collectionCardWidget = BlocProvider.value(
      value: mockBloc,
      child: MaterialApp(
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        home: CollectionCardWidget(
            collection: FlashcardCollection(name: "name", uuid: "uuid")),
      ),
    );
  });
  group('Test [CollectionCardWidget] -', () {
    testWidgets('''Render [CollectionCardWidget], expect at least three [Text],
         one [OutlinedButton], one [FilledButton, one [Column]]''',
        (tester) async {
      await tester.pumpWidget(collectionCardWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsAtLeastNWidgets(3));
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
    testWidgets(
        '''When tapping [OutlinedButton], expect to navigate to [PracticeCardsScreen]''',
        (tester) async {
      await tester.pumpWidget(collectionCardWidget);
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
      await tester.tap(find.byType(OutlinedButton));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(PracticeCardsScreen), findsOneWidget);
    });
    testWidgets(
        '''When tapping [FilledButton], expect to navigate to [CreateFlashcardsScreen]''',
        (tester) async {
      await tester.pumpWidget(collectionCardWidget);
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
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(CreateFlashcardsScreen), findsOneWidget);
    });
  });
}
