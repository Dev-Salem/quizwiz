import '../../../../../tests_imports.dart';

void main() {
  late Widget pasteMaterialWidget;
  setUp(() => pasteMaterialWidget = MaterialApp(
        home: Scaffold(
          body: PastMaterialWidget(
              controller: TextEditingController(),
              collectionUuid: "",
              formKey: GlobalKey()),
        ),
      ));
  group("Test [PasteMaterialWidget] -", () {
    testWidgets(
        "Render [PasteMaterialWidget], expect, [Column], [Padding], [TextFormField], [ElevatedButton]",
        (tester) async {
      await tester.pumpWidget(pasteMaterialWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(Padding), findsAtLeastNWidgets(1));
      expect(find.byType(Icon), findsOneWidget);
    });
  });
}
