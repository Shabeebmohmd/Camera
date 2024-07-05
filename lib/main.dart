import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Cam());

class Cam extends StatelessWidget {
  const Cam({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera',
      home: Camera(),
    );
  }
}
