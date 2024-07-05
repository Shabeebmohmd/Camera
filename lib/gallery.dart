import 'package:flutter/material.dart';
import 'dart:io';

class Gallery extends StatelessWidget {
  final File image;
  final VoidCallback onDelete;

  const Gallery({super.key, required this.image, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Center(
        child: Image.file(image),
      ),
    );
  }
}
