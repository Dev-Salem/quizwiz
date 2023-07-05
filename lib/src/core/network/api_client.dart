import 'package:dio/dio.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/core/utils/private_key.dart';
import 'package:quizwiz/src/core/utils/strings.dart';

class DioClient {
  static Future<Map<String, dynamic>> fetchChatCompletion(String messages,
      {int maxTokens = 200}) async {
    final dio = Dio();
    dio.options.baseUrl = AppStrings.baseUrl;
    dio.options.headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': officialKey,
      'X-RapidAPI-Host': 'chatgpt-api8.p.rapidapi.com'
    };
    try {
      final response = await dio.post('/', data: [
        {
          "role": "user",
          "content": """
pretend to be an expert in summarizing studying material.
create a valid JSON array of objects for $messages 
following this format [no prose], make sure the json starts and ends with quotations:

[
  {
  "term": "clean code",
  "definition": "code that meets the standards"
  },
  {
  "term": "science",
  "definitions": "the pursuit and application of knowledge"
  }

]
 """
        }
      ]);
      return response.data;
    } on DioException catch (e) {
      throw NetworkingException(e.message.toString());
    } on Exception catch (e) {
      if (e.toString().isNotEmpty) {
        throw NetworkingException(e.toString());
      } else {
        throw const UnexpectedNetworkException(
            "Unexpected Exception: Make sure you have internet connection");
      }
    }
  }
}
