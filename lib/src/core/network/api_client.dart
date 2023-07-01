import 'package:dio/dio.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/core/utils/private_key.dart';
import 'package:quizwiz/src/core/utils/strings.dart';

class DioClient {
  static Future<Map<String, dynamic>> fetchChatCompletion(
      List<Map<String, String>> messages,
      {int maxTokens = 200}) async {
    final dio = Dio();
    dio.options.baseUrl = AppStrings.baseUrl;
    dio.options.headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': officialKey,
      'X-RapidAPI-Host': 'chatgpt-api8.p.rapidapi.com'
    };
    try {
      final response = await dio.post('/', data: messages);
      return response.data;
    } on Exception catch (e) {
      throw NetworkingException(e.toString());
    }
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