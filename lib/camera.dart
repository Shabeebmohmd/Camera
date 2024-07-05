import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Camera App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (50.0 / 65.9),
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 9.0,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(34)),
                    child: GestureDetector(
                      onLongPress: () {
                        _alert(_images[index], context);
                      },
                      child: Image.file(_images[index]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                  onPressed: () {
                    _clicker();
                  },
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(100, 60)),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }

  // functions
  Future<void> _requestPermissions() async {
    await Permission.photos.request();
    await Permission.storage.request();
  }

  Future<void> _loadImages() async {
    final dir = await getApplicationDocumentsDirectory();
    final dirPath = '${dir.path}/Folder';
    final myDir = Directory(dirPath);
    if (!await myDir.exists()) {
      await myDir.create(recursive: true);
    }
    final List<FileSystemEntity> entities = await myDir.list().toList();
    final List<File> files = entities.whereType<File>().toList();
    setState(() {
      _images = files;
    });
  }

  // capturing
  Future<void> _clicker() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final dir = await getApplicationDocumentsDirectory();
      final dirPath = '${dir.path}/Folder';
      await Directory(dirPath).create(recursive: true);
      final fileName = basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('$dirPath/$fileName');
      setState(() {
        _images.add(savedImage);
      });
    }
  }

  // Alert
  void _alert(File image, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Image"),
          content: const Text("Are you sure you want to delete this image?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                _deleteImage(image);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // delete function
  void _deleteImage(File image) {
    image.delete();
    setState(() {
      _images.remove(image);
    });
  }
}
