// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
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
}
