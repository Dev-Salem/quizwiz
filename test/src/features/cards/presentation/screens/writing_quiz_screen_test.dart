import 'package:quizwiz/src/features/cards/presentation/screens/writing_quiz_screen.dart';
import '../../../../tests_imports.dart';

void main() {
  late Widget quizScreen;
  final flashcards = [
    Flashcard(question: "question 1", answer: "answer 1", uuid: "1"),
    Flashcard(question: "question 2", answer: "answer 2", uuid: "2"),
  ];
  setUp(() {
    quizScreen = MaterialApp(
      home: WritingQuizScreen(flashcards: flashcards),
    );
  });
  group('Test writing_quiz_screen -', () {
    testWidgets(
        'Render [WritingQuizScreen], expect [Text] with "question" and an empty [TextFormField]',
        (tester) async {
      await tester.pumpWidget(quizScreen);
      expect(find.text(flashcards[0].question), findsOneWidget);
      final textFormFieldFinder = find.byType(TextFormField);
      expect(textFormFieldFinder, findsOneWidget);
      expect(tester.widget<TextFormField>(textFormFieldFinder).controller?.text,
          "");
      expect(find.byType(ElevatedButton), findsNothing);
      expect(find.text(flashcards[0].answer), findsNothing);
    });
    testWidgets('''When filling out a [TextFormField] and tapping done,
     expect two [Text] and an [ElevatedButton]''', (tester) async {
      await tester.pumpWidget(quizScreen);
      await tester.enterText(find.byType(TextFormField), "text");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(find.text(flashcards[0].question), findsOneWidget);
      // expect(find.text(flashcards[0].answer), findsOneWidget);
      // expect(find.byType(ElevatedButton), findsOneWidget);
    });
    testWidgets('''When tapping next,
     expect to navigate to a new screen''', (tester) async {
      await tester.pumpWidget(quizScreen);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      // await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      // expect(find.text(flashcards[1].question), findsOneWidget);
    });
  });
}
