import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

class WritingQuizScreen extends StatefulWidget {
  final List<Flashcard> flashcards;
  const WritingQuizScreen({super.key, required this.flashcards});

  @override
  State<WritingQuizScreen> createState() => _WritingQuizScreenState();
}

class _WritingQuizScreenState extends State<WritingQuizScreen> {
  late final PageController _pageController;
  late final TextEditingController _textController;
  bool _showAnswer = false;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.writingQuiz),
      ),
      body: LayoutBuilder(builder: (context, size) {
        return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: widget.flashcards.length,
            itemBuilder: (context, index) {
              String question = widget.flashcards[index].question;
              String answer = widget.flashcards[index].answer;
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                      constraints:
                          BoxConstraints(maxHeight: size.maxHeight / 3),
                      child: Text(
                        question,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  _showAnswer
                      ? ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: size.maxHeight / 5),
                          child: Text(
                            widget.flashcards[index].answer,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    backgroundColor: _changeAnswerColor(
                                        answer, _textController.text)),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _textController,
                      minLines: 1,
                      maxLines: 3,
                      enabled: !_showAnswer,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _showAnswer = true;
                      },
                      autofocus: true,
                      decoration: const InputDecoration(
                          labelText: "Definition / Answer"),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  _showAnswer
                      ? ElevatedButton.icon(
                          onPressed: () => _onPressed(index),
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text("Next"))
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            });
      }),
    );
  }

  void _onPressed(int index) {
    ///Navigate to home screen if the user reached the las question,
    /// other go to the next question
    if (_pageController.page == widget.flashcards.length - 1) {
      Navigator.of(context).pushReplacementNamed('/');
    } else {
      _textController.clear();
      _showAnswer = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }
  }

  Color _changeAnswerColor(String answer, String userInput) {
    if (answer.trim().toLowerCase() == userInput.trim().toLowerCase()) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
