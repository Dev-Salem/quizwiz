// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

part 'flashcard_collection.g.dart';

@collection
class FlashcardCollection {
  String name;
  String description;
  List<Flashcard> cards;
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true, type: IndexType.hash)
  final String uuid;
  FlashcardCollection({
    required this.name,
    required this.uuid,
    this.description = '',
    this.cards = const [],
  });

  FlashcardCollection copyWith({
    String? name,
    String? description,
    List<Flashcard>? cards,
    Id? id,
    String? uuid,
  }) {
    return FlashcardCollection(
      name: name ?? this.name,
      description: description ?? this.description,
      cards: cards ?? this.cards,
      uuid: uuid ?? this.uuid,
    );
  }
}

@embedded
class Flashcard {
  String question;
  String answer;
  int dueTime;
  double interval;
  double factor;
  int repetitions;
  final String uuid;
  Flashcard({
    this.uuid = '',
    this.question = '',
    this.answer = '',
    this.dueTime = 0,
    this.interval = 1.0,
    this.factor = 2.5,
    this.repetitions = 0,
  });

  Flashcard copyWith({
    String? question,
    String? answer,
    int? dueTime,
    double? interval,
    double? factor,
    int? repetitions,
    String? uuid,
  }) {
    return Flashcard(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      dueTime: dueTime ?? this.dueTime,
      interval: interval ?? this.interval,
      factor: factor ?? this.factor,
      repetitions: repetitions ?? this.repetitions,
      uuid: uuid ?? this.uuid,
    );
  }

  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
        question: map['term'],
        answer: map['definition'],
        uuid: const Uuid().v4());
  }
}
