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
        "When GenerateWithAI button is clicked, expect to navigate to [GenerateCardsScreen] ",
        (tester) async {
      await tester.pumpWidget(createFlashcardsScreen);
      final generateButton = find.byKey(const Key(AppStrings.generateWithAI));
      await tester.tap(generateButton);
      await tester.pumpAndSettle();
      expect(find.byType(GenerateCardsScreen), findsOneWidget);
    });

    testWidgets('''When entering texts into [TextFormField],
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
      var frontTextFormField = find.byKey(const Key("front"));
      var backTextFormField = find.byKey(const Key("back"));
      await tester.enterText(frontTextFormField, "Question");
      await tester.enterText(backTextFormField, "Answer");
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
      var frontTextFormField = find.byKey(const Key("front"));
      var backTextFormField = find.byKey(const Key("back"));
      await tester.enterText(frontTextFormField, "Question");
      await tester.enterText(backTextFormField, "Answer");
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
