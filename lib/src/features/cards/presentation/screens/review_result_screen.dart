import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/review_result_widgets/review_bar.dart';

class ReviewResultScreen extends StatelessWidget {
  final (Flashcard card, String collectionUuid) cardAndCollection;
  const ReviewResultScreen({super.key, required this.cardAndCollection});

  void _addReview(BuildContext buildContext, ReviewResult result) {
    buildContext.read<CardsBloc>().add(UpdateDueTimeEvent(
        card: cardAndCollection.$1,
        collectionUuid: cardAndCollection.$2,
        reviewResult: result));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Text(
            cardAndCollection.$1.question,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            cardAndCollection.$1.answer,
            style: Theme.of(context).textTheme.headlineMedium,
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
      ),
    );
  }
}
