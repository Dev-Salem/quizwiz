import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/presentation/widgets/review_result_widgets/review_bar.dart';

class ReviewResultScreen extends StatelessWidget {
  final Flashcard card;
  const ReviewResultScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card.question,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            card.answer,
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              ReviewBar(
                  color: Colors.red,
                  onTap: () {
                    print('again');
                  },
                  text: "Again"),
              ReviewBar(
                  color: Colors.redAccent,
                  onTap: () {
                    print("hard");
                  },
                  text: "Hard"),
              ReviewBar(
                  color: Colors.green,
                  onTap: () {
                    print("good");
                  },
                  text: "Good"),
              ReviewBar(
                  color: Colors.blue,
                  onTap: () {
                    print("Easy");
                  },
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
