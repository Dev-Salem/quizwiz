import 'package:quizwiz/src/core/core.dart';

abstract class BaseLocalDataSource {
  void generateFlashcards(String material);
}

class DioLocalDataSource extends BaseLocalDataSource {
  @override
  Future<void> generateFlashcards(String material) async {
    try {
      final result = await DioClient.fetchChatCompletion([
        {
          "role": "system",
          "content": """You are a summarizing tool that outputs flashcards
            , the output must be in json format with the following properties:
            question, answer
            """
        },
        {"role": "user", "content": "Summarize this: $material"}
      ]);
      print(result);
    } catch (e) {
      print("He");
    }
  }
}
