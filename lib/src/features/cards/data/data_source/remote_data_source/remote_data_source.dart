import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:uuid/uuid.dart';

abstract class BaseRemoteDataSource {
  factory BaseRemoteDataSource() => DioRemoteDataSource();
  Future<List<Flashcard>> generateFlashcards(String material);
}

class DioRemoteDataSource implements BaseRemoteDataSource {
  @override
  Future<List<Flashcard>> generateFlashcards(String material) async {
    try {
      final result = await DioClient.fetchChatCompletion(material);
      return List<Flashcard>.from(result.map((x) => Flashcard.fromMap(x)));
      /* return [
        Flashcard(
            uuid: Uuid().v4(),
            question: "what do you want to",
            answer: "yes, no, no, no, no, no, no, no, no"),
        Flashcard(
            uuid: Uuid().v4(),
            question: "questions read from the server",
            answer: "answer read from the server  and read from the  server"),
        Flashcard(
            question: "what the hell do you want to",
            answer: "I want to read from the server and read from the server",
            uuid: Uuid().v4()),
      ]; */
    } on Exception catch (e) {
      if (e is NetworkingException || e is UnexpectedNetworkException) {
        rethrow;
      } else {
        throw const JsonDeserializationException(
            "Invalid API response, Try Again");
      }
    }
  }
}
