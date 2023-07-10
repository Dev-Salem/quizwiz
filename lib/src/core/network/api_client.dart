import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/core/network/network_constants.dart';
import 'package:quizwiz/src/core/network/private_key.dart';

class DioClient {
  static Future<List<dynamic>> fetchChatCompletion(String material,
      {int maxTokens = 200}) async {
    final dio = Dio();
    dio.options.validateStatus = (int? status) {
      return status != null && status > 0;
    };
    dio.options.baseUrl = NetworkConstants.baseUrl;
    dio.options.headers = {
      'content-type': NetworkConstants.contentType,
      'X-RapidAPI-Key': officialKey,
      'X-RapidAPI-Host': NetworkConstants.headerHost
    };

    try {
      final response = await dio.post('/', data: [
        {
          "role": "user",
          "content": NetworkConstants.generateFlashcardsPrompt(material)
        }
      ]);
      return jsonDecode(response.data['text']);
    } on Exception catch (e) {
      if (e is DioException) {
        throw NetworkingException(e.message!);
      } else if (e.toString().isNotEmpty) {
        throw NetworkingException(e.toString());
      } else {
        throw const UnexpectedNetworkException(
            "Unexpected Networking Exception: Try To Connect To The Internet");
      }
    } finally {
      dio.close();
    }
  }
}
