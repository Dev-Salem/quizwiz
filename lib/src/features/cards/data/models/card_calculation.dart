import 'dart:math';
import 'package:quizwiz/src/core/utils/enums.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_collection.dart';

class CardCalculation {
  Flashcard card;
  CardCalculation(this.card);

  Flashcard update(
    ReviewResult result,
  ) {
    final now = DateTime.now().millisecondsSinceEpoch;
    switch (result) {
      case ReviewResult.again:
        card.repetitions = 0;
        card.interval = 0;
        card.dueTime = now + _toMilliseconds(card.interval);
        break;
      case ReviewResult.hard:
        card.repetitions = max(1, card.repetitions);
        card.interval = _calculateInterval(card.repetitions, card.factor);
        card.factor = max(1.3, card.factor - 0.15);
        card.dueTime = now + _toMilliseconds(card.interval);
        card.repetitions++;
        break;
      case ReviewResult.good:
        card.repetitions++;
        card.interval = _calculateInterval(card.repetitions, card.factor);
        card.dueTime = now + _toMilliseconds(card.interval);
        break;
      case ReviewResult.easy:
        card.repetitions++;
        card.interval = _calculateInterval(card.repetitions, card.factor);
        card.factor = min(2.5, card.factor + 0.15);
        card.dueTime = now + _toMilliseconds(card.interval);
        break;
    }
    return card;
  }

  double _calculateInterval(int repetitions, double factor) {
    if (repetitions == 1) {
      return 1;
    } else if (repetitions == 2) {
      return 4;
    } else {
      return card.interval * factor;
    }
  }

  int _toMilliseconds(double days) {
    return (days * 24 * 60 * 60 * 1000).toInt();
  }
}
