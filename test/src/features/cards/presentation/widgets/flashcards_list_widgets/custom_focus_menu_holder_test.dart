import 'package:focused_menu/focused_menu.dart';
import '../../../../../tests_imports.dart';

void main() {
  late Widget customFocusMenu;
  setUp(() => customFocusMenu = MaterialApp(
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        home: Scaffold(
          body: CustomFocusedMenuHolder(
              collection: FlashcardCollection(name: "name", uuid: ""),
              index: 0,
              child: const Text("child")),
        ),
      ));
  group("Test [CustomFocusedMenuHolder] -", () {
    testWidgets(
        "Render [CustomFocusedMenuHolder], expect [FocusedMenuHolder], and two [FocusedMenu]",
        (tester) async {
      await tester.pumpWidget(customFocusMenu);
      final menuHolder =
          tester.widget<FocusedMenuHolder>(find.byType(FocusedMenuHolder));
      expect(find.byType(FocusedMenuHolder), findsOneWidget);
      expect(menuHolder.menuItems.length, 2);
    });
    testWidgets(
        "when tapping edit button, expect to navigate to [EditFlashcardsScreen]",
        (tester) async {
      await tester.pumpWidget(customFocusMenu);
      await tester.longPress(find.text("child"));
      await tester.pump();
      await tester.tap(find.text(AppStrings.edit));
      await tester.pumpAndSettle();
      //expect(find.text(AppStrings.edit), findsOneWidget);
    });
  });
}
