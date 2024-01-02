import 'package:dio/dio.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'dart:io';

abstract class BaseRemoteDataSource {
  factory BaseRemoteDataSource() => DioRemoteDataSource();
  Future<List<Flashcard>> generateFlashcards(File file);
}

class DioRemoteDataSource implements BaseRemoteDataSource {
  @override
  Future<List<Flashcard>> generateFlashcards(File file) async {
    try {
      final api = ApiProvider(Dio());
      final List<dynamic> result = await api.getResult(file);
      final flashcards = result.map((e) => Flashcard.fromMap(e)).toList();
      return flashcards;
    } on Exception {
      rethrow;
    }
  }
}
