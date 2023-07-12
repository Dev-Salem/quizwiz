import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';

abstract class BaseRemoteDataSource {
  Future<List<Flashcard>> generateFlashcards(String material);
}

class DioRemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<Flashcard>> generateFlashcards(String material) async {
    try {
      final result = await DioClient.fetchChatCompletion(material);
      return List<Flashcard>.from(result.map((x) => Flashcard.fromMap(x)));
    } on NetworkingException {
      rethrow;
    } on Exception {
      throw const JsonDeserializationException(
          "Could not deserialize flashcards");
    }
  }
}
