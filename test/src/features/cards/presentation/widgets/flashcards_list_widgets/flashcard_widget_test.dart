import '../../../../../tests_imports.dart';

void main() {
  late Widget flashcardWidget;
  setUp(() => flashcardWidget = MaterialApp(
        home: Scaffold(
          body: FlashcardWidget(
              card: Flashcard(
                  question: "question",
                  answer: "answer",
                  dueTime: DateTime.now().millisecondsSinceEpoch)),
        ),
      ));
  group("Test [FlashcardWidget] -", () {
    testWidgets(
        "Render [FlashcardWidget], expect [Card], two [Padding], [Column], three [Text]",
        (tester) async {
      await tester.pumpWidget(flashcardWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Padding), findsAtLeastNWidgets(2));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
    });
  });
}
