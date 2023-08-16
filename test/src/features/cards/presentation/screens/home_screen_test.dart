import '../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late CardsBloc mockBloc = CardsBlocMock();
  late Widget homeScreen;
  setUp(() {
    mockBloc = CardsBlocMock();
    homeScreen = BlocProvider.value(
      value: mockBloc,
      child: const MaterialApp(home: HomeScreen()),
    );
  });
  group("Test home_screen page when it's loading, loaded and has an error - ",
      () {
    testWidgets(
        "when [collectionsRequestState] is loading, expect LoadingWidget",
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: const CardsState());
      await tester.pumpWidget(homeScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
    testWidgets(
        "when [collectionsRequestState] is success (loaded), expect loading then a list of collections (One Collection)",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              collectionsRequestState: RequestState.success,
              collections: [FlashcardCollection(name: "name", uuid: "uuid")])),
          initialState: const CardsState());
      await tester.pumpWidget(homeScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(CollectionsListScreen), findsOneWidget);
      expect(find.byType(CollectionCardWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        "when [collectionsRequestState] is success (loaded), expect loading then [NoResultScreen] (an empty collection)",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(const CardsState(
              collectionsRequestState: RequestState.success, collections: [])),
          initialState: const CardsState());
      await tester.pumpWidget(homeScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(NoResultScreen), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        "when [collectionsRequestState] has error, expect [CustomErrorWidget]",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(const CardsState(
              collectionsRequestState: RequestState.error,
              collectionsErrorMessage: "Some Error")),
          initialState: const CardsState());
      await tester.pumpWidget(homeScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(CustomErrorWidget), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets(
        "When tapping a [FloatingActionButton], expect [CreateCollectionDialogue] to appear",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(const CardsState(
              collectionsRequestState: RequestState.success, collections: [])),
          initialState: const CardsState());
      await tester.pumpWidget(homeScreen);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.byType(CreateCollectionDialog), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(TextButton), findsNWidgets(2));
    });

    testWidgets(
        "When tapping a [FloatingActionButton] and filling out [TextFormField] then tapping create, expect a new collection to appear",
        (tester) async {
      //first: render the page with [NoResultScreen] (No collections at all)
      whenListen(
          mockBloc,
          Stream.fromIterable([
            CardsState(
                collectionsRequestState: RequestState.success,
                collections: [FlashcardCollection(name: "name", uuid: "uuid")]),
          ]),
          initialState: const CardsState(
              collectionsRequestState: RequestState.success, collections: []));
      await tester.pumpWidget(homeScreen);
      expect(find.byType(NoResultScreen), findsOneWidget);
      //second: tap on the [FloatingActionButton], expect a dialog to appear
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.byType(CreateCollectionDialog), findsOneWidget);
      //third: fill out the [TextFormField], and then click create. expect 1)
      //the dialog to be dismissed and a new collection to appear.
      await tester.enterText(
          find.byKey(const Key(AppStrings.nameTextFieldLabel)), "name");
      await tester.enterText(
          find.byKey(const Key(AppStrings.descriptionTextFieldLabel)), "");
      await tester.tap(find.byKey(const Key(AppStrings.create)));
      await tester.pump();
      expect(find.byType(CreateCollectionDialog), findsNothing);
      expect(find.byType(NoResultScreen), findsNothing);
      expect(find.byType(CollectionCardWidget), findsOneWidget);
    });
  });
}
