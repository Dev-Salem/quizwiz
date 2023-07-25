// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DisplayQuestionWidget extends StatelessWidget {
  final String question;
  final BoxConstraints size;
  const DisplayQuestionWidget({
    Key? key,
    required this.question,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.maxHeight * 0.15,
        child: AutoSizeText(
          question,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall,
        ));
  }
}
