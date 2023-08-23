import '../../../../../tests_imports.dart';

void main() {
  late Widget customForms;
  setUp(() => customForms = MaterialApp(
        home: Scaffold(
          body: CustomForms(
              frontController: TextEditingController(),
              backController: TextEditingController(),
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
      await tester.enterText(find.byKey(const Key('front')), "front text");
      await tester.enterText(find.byKey(const Key("back")), "back text");
      final frontController =
          tester.widget<TextFormField>(find.byKey(const Key("front")));
      final backController =
          tester.widget<TextFormField>(find.byKey(const Key("back")));
      expect(frontController.controller?.text, "front text");
      expect(backController.controller?.text, "back text");
    });
  });
}
