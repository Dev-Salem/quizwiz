import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:quizwiz/src/core/errors/exceptions.dart';
import 'package:quizwiz/src/core/network/network_constants.dart';
import 'package:quizwiz/src/core/network/private_key.dart';
import 'package:quizwiz/src/core/services/internet_connection.dart';

class DioClient {
  static Future<List<dynamic>> fetchChatCompletion(String material,
      {int maxTokens = 200}) async {
    final isConnected = await InternetConnectivity.isConnected();
    if (!isConnected) {
      print(isConnected);
      throw const NetworkingException("No Internet connection");
    }
    final dio = Dio();
    dio.options.validateStatus = (int? status) {
      return status != null && status > 0;
    };
    dio.options.baseUrl = NetworkConstants.gptBaseUrl;
    dio.options.headers = {
      'content-type': NetworkConstants.contentType,
      'X-RapidAPI-Key': gptApiKey,
      'X-RapidAPI-Host': NetworkConstants.gptHeaderHost
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
      throw _customException(e);
    } finally {
      dio.close();
    }
  }
}

Exception _customException(Exception e) {
  if (e is DioException) {
    return NetworkingException(e.message!);
  } else if (e.toString().isNotEmpty) {
    return NetworkingException(e.toString());
  } else {
    return const UnexpectedNetworkException(
        "Unexpected Network Exception: Try Connecting To The Internet");
  }
}
