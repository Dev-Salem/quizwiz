import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/core/utils/network_constants.dart';
import 'package:quizwiz/src/core/utils/private_key.dart';

class DioClient {
  static Future<List<dynamic>> generateFlashcards(String material,
      {int maxTokens = 200}) async {
    const timeout = Duration(minutes: 2);
    final isConnected = await InternetConnectivity.isConnected();
    if (!isConnected) {
      throw const NetworkException(NetworkConstants.noConnectionErrorMessage);
    }

    final dio = Dio();
    dio.options.validateStatus = (int? status) {
      return status != null && status > 0;
    };
    dio.options
      ..baseUrl = NetworkConstants.gptBaseUrl
      ..sendTimeout = timeout
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..headers = {
        'content-type': NetworkConstants.contentType,
        //TODO: Get An API Key
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
  if (e is FormatException) {
    return const NetworkException(NetworkConstants.formatExceptionMessage);
  } else if (e is DioException) {
    return e.type == DioExceptionType.unknown
        ? const NetworkException(NetworkConstants.invalidNetworkErrorMessage)
        : NetworkException(e.message!);
  } else if (e.toString().isNotEmpty) {
    return NetworkException(e.toString());
  } else {
    return const UnexpectedNetworkException(
        NetworkConstants.unexpectedErrorMessage);
  }
}
