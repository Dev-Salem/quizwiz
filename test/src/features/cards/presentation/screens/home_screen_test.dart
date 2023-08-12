import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

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
  group("Test home_screen page when it's loading, loaded and has error", () {
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
  });
}
