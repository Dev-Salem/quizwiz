import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

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
              return SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      DisplayQuestionWidget(question: question, size: size),
                      const SizedBox(
                        height: 30,
                      ),
                      _showAnswer
                          ? DisplayAnswerWidget(
                              answer: answer,
                              size: size,
                              textbackgroundColor: _changeAnswerColor(
                                  answer, _textController.text))
                          : SizedBox(
                              height: size.maxHeight * 0.2,
                            ),
                      const SizedBox(
                        height: 50,
                      ),
                      AnswerFormField(
                          controller: _textController,
                          enabled: !_showAnswer,
                          onSubmit: (value) => _showAnswer = true),
                      SizedBox(
                        height: size.maxHeight * 0.2,
                      ),
                      _showAnswer
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ElevatedButton.icon(
                                  onPressed: () => _onPressed(index),
                                  icon: const Icon(Icons.arrow_forward),
                                  label: const Text("Next")),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }

  void _onPressed(int index) {
    ///Navigate to home screen if the user reached the las question,
    /// otherwise go to the next question
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
