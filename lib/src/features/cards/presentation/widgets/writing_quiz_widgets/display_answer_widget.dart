// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DisplayAnswerWidget extends StatelessWidget {
  final String answer;
  final BoxConstraints size;
  final Color textBackgroundColor;
  const DisplayAnswerWidget({
    Key? key,
    required this.answer,
    required this.size,
    required this.textBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.maxHeight * 0.25,
      child: AutoSizeText(
        answer,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(backgroundColor: textBackgroundColor),
      ),
    );
  }
}
