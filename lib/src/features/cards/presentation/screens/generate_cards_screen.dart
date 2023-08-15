// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quizwiz/src/features/cards/presentation/presentation.dart';

class GenerateCardsScreen extends StatefulWidget {
  final String collectionUuid;
  const GenerateCardsScreen({super.key, required this.collectionUuid});

  @override
  State<GenerateCardsScreen> createState() => _GenerateCardsScreenState();
}

class _GenerateCardsScreenState extends State<GenerateCardsScreen> {
  late final TextEditingController _controller;
  final formKey = GlobalKey<FormState>();
  String index = 'text';
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
        body: LayoutBuilder(builder: (context, size) {
          return Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: RadioListTile.adaptive(
                        key: const Key('text'),
                        title: const Text("Plain Text"),
                        value: "text",
                        groupValue: index,
                        onChanged: (value) {
                          setState(() {
                            index = value ?? index;
                          });
                        }),
                  ),
                  Expanded(
                    child: RadioListTile.adaptive(
                        key: const Key('pdf'),
                        title: const Text("Upload PDF"),
                        value: "pdf",
                        groupValue: index,
                        onChanged: (value) {
                          setState(() {
                            index = value ?? index;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: size.maxHeight * 0.25,
              ),
              index == 'text'
                  ? PastMaterialWidget(
                      controller: _controller,
                      collectionUuid: widget.collectionUuid,
                      formKey: formKey)
                  : UploadFileWidget(
                      collectionUuid: widget.collectionUuid,
                    )
            ],
          );
        }));
  }
}
