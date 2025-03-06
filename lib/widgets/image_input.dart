import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imageinput extends StatefulWidget {
  const Imageinput({super.key, required this.onpickedimage});
  final void Function(File image) onpickedimage;

  @override
  State<Imageinput> createState() => _ImageinputState();
}

class _ImageinputState extends State<Imageinput> {
  File? _selectedimage;
  void _takepictures() async {
    final imagepicked = ImagePicker();
    final pickedimage = await imagepicked.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedimage == null) {
      return;
    }
    setState(() {
      _selectedimage = File(pickedimage.path);
    });
    widget.onpickedimage(_selectedimage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takepictures,
      icon: const Icon(Icons.camera_alt),
      label: const Text('take pictures'),
    );
    if (_selectedimage != null) {
      content = GestureDetector(
        onTap: _takepictures,
        child: Image.file(
          _selectedimage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
