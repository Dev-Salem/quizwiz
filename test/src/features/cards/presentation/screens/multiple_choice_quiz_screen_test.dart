import '../../../../tests_imports.dart';

class CardsBlocMock extends MockBloc<CardsEvents, CardsState>
    implements CardsBloc {}

void main() {
  late Widget multipleChoiceScreen;
  late CardsBloc mockBloc;
  final quizzes = [
    const MultipleChoiceQuiz(
        question: "question",
        options: ["answer", "a1", "a2", "a3"],
        rightAnswer: "answer"),
    const MultipleChoiceQuiz(
        question: "question 2",
        options: ["answer 2", "b1", "b2", "b3"],
        rightAnswer: "answer 2"),
    const MultipleChoiceQuiz(
        question: "question 3",
        options: ["answer 3", "c1", "c2", "c3"],
        rightAnswer: "answer 3"),
    const MultipleChoiceQuiz(
        question: "question 4",
        options: ["answer 4", "d1", "d2", "d3"],
        rightAnswer: "answer 4"),
  ];
  setUp(() {
    mockBloc = CardsBlocMock();
    multipleChoiceScreen = BlocProvider.value(
      value: mockBloc,
      child: MaterialApp(
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        home: const MultipleChoiceQuizScreen(),
      ),
    );
  });
  group("Test multiple_choice_quiz_screen", () {
    testWidgets("When [quizRequestState] is loading, expect [LoadingWidget]",
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: const CardsState());
      await tester.pumpWidget(multipleChoiceScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });
    testWidgets(
        "When [quizRequestState] has an error, expect [LoadingWidget] then [CustomErrorWidget]",
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(const CardsState(
              quizRequestState: RequestState.error,
              quizErrorMessage: "error message")),
          initialState: const CardsState());
      await tester.pumpWidget(multipleChoiceScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(CustomErrorWidget), findsOneWidget);
      expect(find.text("Error:error message"), findsOneWidget);
    });
    testWidgets('''When [quizRequestState] is success,
         expect [LoadingWidget] then [MultipleChoiceQuizBody], and 6 [Text] widgets''',
        (tester) async {
      whenListen(
          mockBloc,
          Stream.value(CardsState(
              quizRequestState: RequestState.success,
              multipleChoices: quizzes)),
          initialState: const CardsState());
      await tester.pumpWidget(multipleChoiceScreen);
      expect(find.byType(LoadingWidget), findsOneWidget);
      await tester.pump();
      expect(find.byType(MultipleChoiceQuizBody), findsOneWidget);
      expect(find.text(quizzes[0].question), findsOneWidget);
      expect(find.text(quizzes[0].rightAnswer), findsOneWidget);
      //one for question, one for for app bar, 4 for options
      expect(find.byType(Text), findsNWidgets(6));
    });

    testWidgets('''When [quizRequestState] is success and tapping an option,
         expect to navigate to the next question''', (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: CardsState(
              quizRequestState: RequestState.success,
              multipleChoices: quizzes));
      await tester.pumpWidget(multipleChoiceScreen);
      await tester.tap(find.text(quizzes[0].rightAnswer));
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();
      expect(find.text(quizzes[1].question), findsOneWidget);
      expect(find.widgetWithText(Container, quizzes[1].rightAnswer),
          findsOneWidget);
    });

    testWidgets(
        '''When [quizRequestState] is success and tapping the right option,
         expect to highlight the right answer with green answerground color''',
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: CardsState(
              quizRequestState: RequestState.success,
              multipleChoices: quizzes));
      await tester.pumpWidget(multipleChoiceScreen);
      //color of the container before tapping
      final containerBeforeTapping = tester.widget<Container>(
          find.widgetWithText(Container, quizzes[0].rightAnswer));
      expect(containerBeforeTapping.color, isNot(Colors.green));

      //tap the right answer
      await tester.tap(find.text(quizzes[0].rightAnswer));
      await tester.pump(const Duration(milliseconds: 400));

      //color of the container after tapping
      final containerAfterTapping = tester.widget<Container>(
          find.widgetWithText(Container, quizzes[0].rightAnswer));
      expect(containerAfterTapping.color, Colors.green);
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();
    });

    testWidgets(
        '''When [quizRequestState] is success and tapping any other option,
         expect to highlight the right answer with green answerground color''',
        (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: CardsState(
              quizRequestState: RequestState.success,
              multipleChoices: quizzes));
      await tester.pumpWidget(multipleChoiceScreen);
      //color of the container before tapping
      final containerBeforeTapping = tester.widget<Container>(
          find.widgetWithText(Container, quizzes[0].rightAnswer));
      expect(containerBeforeTapping.color, isNot(Colors.green));

      //tap a random option
      await tester.tap(find.text(quizzes[0].options[1]));
      await tester.pump(const Duration(milliseconds: 400));

      //color of the container after tapping
      final containerAfterTapping = tester.widget<Container>(
          find.widgetWithText(Container, quizzes[0].rightAnswer));
      expect(containerAfterTapping.color, Colors.green);
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();
    });

    testWidgets('''When tapping an option, and the question is the last one,
     expect to navigate to [HomeScreen]''', (tester) async {
      whenListen(mockBloc, const Stream<CardsState>.empty(),
          initialState: CardsState(
              quizRequestState: RequestState.success,
              multipleChoices: quizzes));
      await tester.pumpWidget(multipleChoiceScreen);
      //first question
      expect(find.text(quizzes[0].question), findsOneWidget);
      await tester.tap(find.text(quizzes[0].options[1]));
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();

      //second question
      expect(find.text(quizzes[1].question), findsOneWidget);
      await tester.tap(find.text(quizzes[1].options[1]));
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();

      //third question
      expect(find.text(quizzes[2].question), findsOneWidget);
      await tester.tap(find.text(quizzes[2].options[1]));
      await tester.pump(const Duration(milliseconds: 2000));
      await tester.pumpAndSettle();

      //last question
      expect(find.text(quizzes[3].question), findsOneWidget);
      await tester.tap(find.text(quizzes[3].options[2]));
      await tester.pump(const Duration(milliseconds: 3000));
      await tester.pumpAndSettle();
      //expect(find.byType(HomeScreen), findsWidgets);
    });
  });
}
