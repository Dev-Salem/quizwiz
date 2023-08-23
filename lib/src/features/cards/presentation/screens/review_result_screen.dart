import 'package:auto_size_text/auto_size_text.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class ReviewResultScreen extends StatelessWidget {
  final (Flashcard card, FlashcardCollection collection) cardAndCollection;
  const ReviewResultScreen({super.key, required this.cardAndCollection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, size) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.maxHeight / 4),
                child: AutoSizeText(
                  cardAndCollection.$1.question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: size.maxHeight / 3.5),
                child: AutoSizeText(
                  cardAndCollection.$1.answer,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              children: [
                ReviewBar(
                    color: Colors.red,
                    onTap: () => _addReview(context, ReviewResult.again),
                    text: "Again"),
                ReviewBar(
                    color: Colors.redAccent,
                    onTap: () => _addReview(context, ReviewResult.hard),
                    text: "Hard"),
                ReviewBar(
                    color: Colors.green,
                    onTap: () => _addReview(context, ReviewResult.good),
                    text: "Good"),
                ReviewBar(
                    color: Colors.blue,
                    onTap: () => _addReview(context, ReviewResult.easy),
                    text: "Easy"),
              ],
            ),
            const SizedBox(
              height: 25,
            )
          ],
        );
      }),
    );
  }

  void _addReview(BuildContext buildContext, ReviewResult result) {
    buildContext.read<CardsBloc>()
      ..add(UpdateDueTimeEvent(
          card: cardAndCollection.$1,
          collectionUuid: cardAndCollection.$2.uuid,
          reviewResult: result))
      ..add(GetDueReviewsEvent(collection: cardAndCollection.$2));

    Navigator.of(buildContext).pushReplacementNamed(Routes.practiceCards,
        arguments: cardAndCollection.$2);
  }
}
