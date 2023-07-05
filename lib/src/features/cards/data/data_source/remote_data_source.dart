import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_api_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<Flashcard>> generateFlashcards(String material);
}

class DioRemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<List<Flashcard>> generateFlashcards(String material) async {
    final result = await DioClient.fetchChatCompletion(material);
    try {
      return FlashcardsModel.fromJson(result).flashcards;
    } on Exception {
      throw const JsonDeserializationException(
          "Could not deserialize flashcards");
    }
  }
}
