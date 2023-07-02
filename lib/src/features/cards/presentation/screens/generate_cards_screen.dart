import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizwiz/src/core/core.dart';

class GenerateCardsScreen extends StatefulWidget {
  const GenerateCardsScreen({super.key});

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
                final result = await DioClient.fetchChatCompletion([
                  {
                    "role": "user",
                    "content": """
pretend to be an expert in summarizing studying material.
create a valid JSON array of objects for ${_controller.text} following this format [no prose]:

[
{"clean code": "code that meets the standards"},
{"science": "the pursuit and application of knowledge"}
]
 """
                  }
                ]);
                log(result.toString());
              },
              icon: const Icon(Icons.rocket),
              label: const Text("Generate"))
        ],
      ),
    );
  }
}
