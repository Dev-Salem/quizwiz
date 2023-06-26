import 'package:flutter/material.dart';

class ReviewBar extends StatelessWidget {
  final Color color;
  final String text;
  final Function() onTap;
  const ReviewBar(
      {super.key,
      required this.color,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          color: color,
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
