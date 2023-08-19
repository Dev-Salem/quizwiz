import '../../../../tests_imports.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late CardsBloc mockBloc = CardsBlocMock();
  late Widget flashcardWidget;
  setUp(() {
    mockBloc = CardsBlocMock();
    flashcardWidget = BlocProvider.value(
      value: mockBloc,
      child: const MaterialApp(
          home: FlashcardsListScreen(
        collectionUuid: "",
      )),
    );
  });
  tearDown(() {
    mockBloc.close();
  });
  group("Test flash_cards_screen when it's loading, loaded and has error - ",
      () {
    testWidgets(
        "when [collectionsRequestState] is loading, expect [LoadingWidget]",
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: const CardsState());
      await tester.pumpWidget(flashcardWidget);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });
    testWidgets(
        "when [collectionsRequestState] is success (loaded), expect loading then a list of flashcards",
        (tester) async {
      whenListen(
          mockBloc,
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
      await tester.pumpWidget(flashcardWidget);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(MasonryGridView), findsOneWidget);
      expect(find.byType(CustomFocusedMenuHolder), findsNWidgets(3));
      expect(find.byType(FlashcardWidget), findsNWidgets(3));
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        "when [collectionsRequestState] is success (loaded), expect loading then [NoResultScreen] (an empty flashcards list)",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "", uuid: "")])),
          initialState: const CardsState());
      await tester.pumpWidget(flashcardWidget);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(NoResultScreen), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
    testWidgets(
        "when [collectionsRequestState] has error, expect [CustomErrorWidget]",
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: const CardsState(
              collectionsRequestState: RequestState.error,
              collectionsErrorMessage: "Some Error"));
      await tester.pumpWidget(flashcardWidget);
      expect(find.byType(CustomErrorWidget), findsOneWidget);
    });
  });
}
