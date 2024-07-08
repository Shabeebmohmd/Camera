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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          'Images',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white54,
            ),
            onPressed: () {
              onDelete();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.file(image),
        ),
      ),
    );
  }
}
