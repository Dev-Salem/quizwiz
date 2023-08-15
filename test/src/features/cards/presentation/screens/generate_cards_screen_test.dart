import 'package:flutter_test/flutter_test.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

void main() {
  late Widget generateCardsScreen;
  setUp(() {
    generateCardsScreen =
        const MaterialApp(home: GenerateCardsScreen(collectionUuid: ""));
  });
  group("Test generate_cards_screen -", () {
    testWidgets("Render generate_cards_screen", (tester) async {
      await tester.pumpWidget(generateCardsScreen);
      expect(find.byType(GenerateCardsScreen), findsOneWidget);
      expect(find.byType(RadioListTile<String>), findsNWidgets(2));
      expect(find.byType(LayoutBuilder), findsOneWidget);
      expect(find.byType(Expanded), findsNWidgets(2));
    });
    testWidgets(
        "when Upload pdf radio is tapped, expect one [UploadFileWidget] widget",
        (tester) async {
      await tester.pumpWidget(generateCardsScreen);
      await tester.tap(find.byKey(const Key('pdf')));
      await tester.pump();
      expect(find.byType(UploadFileWidget), findsOneWidget);
      expect(find.byType(PastMaterialWidget), findsNothing);
    });
    testWidgets(
        "when paste material radio is tapped, expect one [PastMaterialWidget] widget",
        (tester) async {
      await tester.pumpWidget(generateCardsScreen);
      await tester.tap(find.byKey(const Key('text')));
      await tester.pump();
      expect(find.byType(UploadFileWidget), findsNothing);
      expect(find.byType(PastMaterialWidget), findsOneWidget);
    });
  });
}
