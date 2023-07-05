import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/data/data.dart';
import 'package:quizwiz/src/features/cards/data/models/flashcard_api_model.dart'
    as model;

class GenerateCardsScreen extends StatefulWidget {
  final FlashcardCollection collection;
  const GenerateCardsScreen({super.key, required this.collection});

  @override
  State<GenerateCardsScreen> createState() => _GenerateCardsScreenState();
}

class _GenerateCardsScreenState extends State<GenerateCardsScreen> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: _controller,
          ),
          ElevatedButton.icon(
              onPressed: () async {
                // final result =
                //     await DioClient.fetchChatCompletion(_controller.text);
                // final flashcards = model.FlashcardsModel.fromJson(result);
                // print(flashcards);
                Navigator.of(context).pushReplacementNamed(
                    RouterConstance.goToGeneratedFlashcards);
              },
              icon: const Icon(Icons.rocket),
              label: const Text("Generate"))
        ],
      ),
    );
  }
}
