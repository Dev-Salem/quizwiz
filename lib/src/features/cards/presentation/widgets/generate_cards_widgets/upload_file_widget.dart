import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:quizwiz/src/core/core.dart';
import 'package:quizwiz/src/features/cards/controller/controller.dart';

class UploadFileWidget extends StatelessWidget {
  final String collectionUuid;
  const UploadFileWidget({super.key, required this.collectionUuid});

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
        iconSize: 36,
        onPressed: () async {
          final file = await pickFile();
          if (file != null) {
            final String text = await extractText(file);
            if (context.mounted) generateAndNavigate(context, text);
          } else {
            if (context.mounted) customSnackBar("Pick A PDF File", context);
          }
        },
        icon: const Icon(Icons.upload_file));
  }

  void generateAndNavigate(BuildContext context, String text) {
    context.read<CardsBloc>().add(GenerateFlashcardsEvent(material: text));
    Navigator.of(context).pushReplacementNamed(
        RouterConstance.goToGeneratedFlashcards,
        arguments: collectionUuid);
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<String> extractText(File file) async {
    final pdf = await PDFDoc.fromFile(file);
    return await pdf.text;
  }
}
