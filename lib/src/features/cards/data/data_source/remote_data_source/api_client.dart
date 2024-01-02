// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizwiz/src/core/core.dart';

class ApiProvider {
  final Dio _dio;
  ApiProvider(this._dio);

  Future<dynamic> getResult(
    File file,
  ) async {
    try {
      final apiKey = dotenv.get(NetworkConstants.apiKeyName);
      _dio.options.headers = {
        'x-api-key': apiKey,
        'Content-Type': 'application/json'
      };
      final sourceId = await _uploadFile(file, apiKey);
      final result =
          await _generateFlashcards(apiKey: apiKey, fileSourceId: sourceId);
      await _deleteFile(sourceId, apiKey);
      return result;
    } on Exception {
      rethrow;
    } finally {
      // _dio.close();
    }
  }

  Future<String> _uploadFile(File file, apiKey) async {
    try {
      final fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Response response = await _dio.post(
        NetworkConstants.addFileEndPoint,
        data: formData,
      );
      return response.data['sourceId'];
    } on Exception catch (e) {
      throw NetworkException(e.toString());
    }
  }

  Future<dynamic> _generateFlashcards(
      {required String apiKey, required String fileSourceId}) async {
    try {
      final data = {
        "sourceId": fileSourceId,
        "messages": [
          {"role": 'user', "content": NetworkConstants.generateFlashcardsPrompt}
        ]
      };
      Response response = await _dio.post(
        NetworkConstants.chatEndPoint,
        data: data,
      );
      return jsonDecode(response.data['content']);
    } on Exception {
      rethrow;
    }
  }

  Future<void> _deleteFile(String fileSourceId, apiKey) async {
    final data = {
      'sources': [fileSourceId]
    };
    try {
      _dio.post(
        NetworkConstants.deleteFileEndPoint,
        data: data,
      );
    } on Exception {
      rethrow;
    }
  }
}
