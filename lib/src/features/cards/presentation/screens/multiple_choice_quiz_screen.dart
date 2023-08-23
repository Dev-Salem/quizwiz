import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class MultipleChoiceQuizScreen extends StatefulWidget {
  const MultipleChoiceQuizScreen({super.key});

  @override
  State<MultipleChoiceQuizScreen> createState() =>
      _MultipleChoiceQuizScreenState();
}

class _MultipleChoiceQuizScreenState extends State<MultipleChoiceQuizScreen> {
  bool showCorrectAnswer = false;
  late final PageController _controller;
  final int _slideDuration = 400; //time in milliseconds
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeAnswerColor() {
    setState(() {
      showCorrectAnswer = !showCorrectAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.multipleChoice),
      ),
      body: BlocBuilder<CardsBloc, CardsState>(
        builder: (context, state) {
          switch (state.quizRequestState) {
            case RequestState.loading:
              return const LoadingWidget();
            case RequestState.error:
              return CustomErrorWidget(
                errorMessage: state.quizErrorMessage,
              );
            case RequestState.success:
              final quiz = state.multipleChoices;
              return MultipleChoiceQuizBody(
                  quiz: quiz,
                  controller: _controller,
                  showCorrectAnswer: showCorrectAnswer,
                  onTap: _onTap);
          }
        },
      ),
    );
  }

  void _onTap(int index, List<MultipleChoiceQuiz> quiz) {
    //change the color to green
    _changeAnswerColor();
    //after [_slideDuration + 100ms] change the color answer
    Future.delayed(Duration(milliseconds: _slideDuration + 100),
        () => _changeAnswerColor());
    //if this's the last question, navigate to the home page, else slide to the
    //next question
    if (index == quiz.length - 1) {
      Future.delayed(Duration(milliseconds: _slideDuration),
          () => Navigator.of(context).pushReplacementNamed('/'));
    } else {
      Future.delayed(
          Duration(milliseconds: _slideDuration + 500),
          () => _controller.nextPage(
              duration: Duration(milliseconds: _slideDuration),
              curve: Curves.easeInOut));
    }
  }
}
