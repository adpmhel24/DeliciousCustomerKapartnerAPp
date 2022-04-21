import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kapartner_app/presentation/widget/constant.dart';

class AttachmentViewer extends StatelessWidget {
  const AttachmentViewer({
    Key? key,
    required this.imageFile,
    required this.onDelete,
  }) : super(key: key);

  final File imageFile;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageFile.path),
        iconTheme: const IconThemeData(color: Colors.red),
        actions: [
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
            splashRadius: Constant.splashRadius,
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          child: Hero(
            tag: imageFile,
            child: Image.file(
              imageFile,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
