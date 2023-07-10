import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/review_result_widgets/review_bar.dart';

class ReviewResultScreen extends StatelessWidget {
  final (Flashcard card, FlashcardCollection collection) cardAndCollection;
  const ReviewResultScreen({super.key, required this.cardAndCollection});

  void _addReview(BuildContext buildContext, ReviewResult result) {
    buildContext.read<CardsBloc>()
      ..add(UpdateDueTimeEvent(
          card: cardAndCollection.$1,
          collectionUuid: cardAndCollection.$2.uuid,
          reviewResult: result))
      ..add(GetDueReviewsEvent(collection: cardAndCollection.$2));

    Navigator.of(buildContext).pushReplacementNamed(
        RouterConstance.goToPracticeCards,
        arguments: cardAndCollection.$2);
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
                  text: ReviewResult.again.toString()),
              ReviewBar(
                  color: Colors.redAccent,
                  onTap: () => _addReview(context, ReviewResult.hard),
                  text: ReviewResult.hard.toString()),
              ReviewBar(
                  color: Colors.green,
                  onTap: () => _addReview(context, ReviewResult.good),
                  text: ReviewResult.good.toString()),
              ReviewBar(
                  color: Colors.blue,
                  onTap: () => _addReview(context, ReviewResult.easy),
                  text: ReviewResult.easy.toString()),
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
