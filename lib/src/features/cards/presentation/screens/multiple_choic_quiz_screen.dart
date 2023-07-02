import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/widgets/error_widget.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class MultipleChoiceQuizScreen extends StatefulWidget {
  const MultipleChoiceQuizScreen({super.key});

  @override
  State<MultipleChoiceQuizScreen> createState() =>
      _MultipleChoiceQuizScreenState();
}

class _MultipleChoiceQuizScreenState extends State<MultipleChoiceQuizScreen> {
  bool showCorrectAnswer = false;
  late final PageController _controller;
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

  void onTap(int index, List<MultipleChoiceQuiz> quiz) {
    _changeAnswerColor();
    Future.delayed(
        const Duration(milliseconds: 500), () => _changeAnswerColor());
    if (index == quiz.length - 1) {
      Future.delayed(const Duration(milliseconds: 400),
          () => Navigator.of(context).pushReplacementNamed('/'));
    } else {
      Future.delayed(
          const Duration(milliseconds: 900),
          () => _controller.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multiple Choice Quiz"),
      ),
      body: BlocBuilder<CardsBloc, CardsState>(
        builder: (context, state) {
          switch (state.quizRequestState) {
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case RequestState.error:
              return CustomErrorWidget(
                errorMessage: state.quizErrorMessage,
              );
            case RequestState.success:
              final quiz = state.multipleChoices;
              return PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: quiz.length,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Container(
                          height: constraints.maxHeight / 3,
                          alignment: Alignment.center,
                          child: Text(
                            quiz[index].question,
                            style: Theme.of(context).textTheme.displaySmall,
                          )),
                      ...List.generate(quiz[index].options.length, (i) {
                        final option = quiz[index].options[i];
                        return InkWell(
                          onTap: () => onTap(index, quiz),
                          child: Container(
                            width: constraints.maxWidth,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.center,
                            color: option == quiz[index].rightAnswer &&
                                    showCorrectAnswer
                                ? Colors.green
                                : Theme.of(context).cardColor,
                            child: Text(option),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
