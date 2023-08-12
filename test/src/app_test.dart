import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizwiz/src/app.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late CardsBlocMock blocMock;
  setUp(() {
    ServiceLocator().init();
    blocMock = CardsBlocMock();
    sl.unregister<CardsBloc>();
    sl.registerFactory<CardsBloc>(() => blocMock);
  });
  tearDownAll(() {
    sl.reset(dispose: true);
  });
  testWidgets("render QizWiz app, expect to find one widget", (tester) async {
    whenListen(blocMock, const Stream<CardsState>.empty(),
        initialState: const CardsState());
    await tester.pumpWidget(QuizWizApp(
        cardsBloc: sl<CardsBloc>()..add(const GetCollectionsEvent()),
        themeCubit: sl()));
    expect(find.byType(QuizWizApp), findsOneWidget);
  });
}
