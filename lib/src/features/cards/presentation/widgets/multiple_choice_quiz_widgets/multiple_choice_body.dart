// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class MultipleChoiceQuizBody extends StatelessWidget {
  final List<MultipleChoiceQuiz> quiz;
  final PageController controller;
  final bool showCorrectAnswer;
  final Function onTap;
  const MultipleChoiceQuizBody(
      {Key? key,
      required this.quiz,
      required this.controller,
      required this.showCorrectAnswer,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: quiz.length,
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, constraints) => ListView(
          children: [
            Container(
                height: constraints.maxHeight / 3,
                alignment: Alignment.center,
                child: Text(
                  quiz[index].question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                )),
            ...List.generate(quiz[index].options.length, (i) {
              final option = quiz[index].options[i];
              return InkWell(
                onTap: () => onTap(index, quiz),
                child: Container(
                  width: constraints.maxWidth,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  color: option == quiz[index].rightAnswer && showCorrectAnswer
                      ? Colors.green
                      : Theme.of(context).cardColor,
                  child: Text(
                    option,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
