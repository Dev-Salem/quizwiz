import 'package:dio/dio.dart';
import 'package:quizwiz/src/core/utils/private_key.dart';
import 'package:quizwiz/src/core/utils/strings.dart';

class DioClient {
  static Future<Map<String, dynamic>> fetchChatCompletion(
      List<Map<String, String>> messages,
      {int maxTokens = 200}) async {
    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    final requestBody = {
      "model": "gpt-3.5-turbo",
      "max_tokens": maxTokens,
      "messages": messages
    };

    final response = await dio.post(AppStrings.baseUrl);

    return response.data;
  }
}

/*
[
        {
            "role": "system",
            "content": "You are an helpful assistant."
        },
        {
            "role": "user",
            "content": "Who are you?"
        }
    ]
*/