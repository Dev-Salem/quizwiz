import 'package:focused_menu/focused_menu.dart';
import '../../../../../tests_imports.dart';

void main() {
  late Widget collectionListScreen;
  setUp(() {
    collectionListScreen = MaterialApp(
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      home: CollectionsListScreen(
          collections: [FlashcardCollection(name: "name", uuid: "uuid")]),
    );
  });

  group('Test [CollectionListScreen] -', () {
    testWidgets('''Render [CollectionListScreen], expect [ListView],
       [FocusedMenuHolder], and one [CollectionCardWidget] ''', (tester) async {
      await tester.pumpWidget(collectionListScreen);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(FocusedMenuHolder), findsOneWidget);
      expect(find.byType(CollectionCardWidget), findsOneWidget);
    });
  });
}
