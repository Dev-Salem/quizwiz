import '../../../../../tests_imports.dart';

void main() {
  late Widget customForms;
  setUp(() => customForms = MaterialApp(
        home: Scaffold(
          body: CustomForms(
              questionController: TextEditingController(),
              answerController: TextEditingController(),
              formKey: GlobalKey()),
        ),
      ));
  group("Test [CustomForms] widget -", () {
    testWidgets(
        "Render [CustomForms], expect [Form], [Column] and two [TextFormField]",
        (tester) async {
      await tester.pumpWidget(customForms);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsAtLeastNWidgets(2));
    });
    testWidgets(
        "when filling out [TextFormField], expect the same values in the controller",
        (tester) async {
      await tester.pumpWidget(customForms);
      await tester.enterText(
          find.byKey(const Key('question')), "question text");
      await tester.enterText(find.byKey(const Key("answer")), "answer text");
      final questionController =
          tester.widget<TextFormField>(find.byKey(const Key("question")));
      final answerController =
          tester.widget<TextFormField>(find.byKey(const Key("answer")));
      expect(questionController.controller?.text, "question text");
      expect(answerController.controller?.text, "answer text");
    });
  });
}
