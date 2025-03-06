import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/user_places.dart';
import 'package:flutter_application_1/widgets/image_input.dart';
import 'package:flutter_application_1/widgets/location_input.dart';

class addplaces extends ConsumerStatefulWidget {
  const addplaces({super.key});

  @override
  ConsumerState<addplaces> createState() => _addplacesState();
}

class _addplacesState extends ConsumerState<addplaces> {
  final _titlecontroler = TextEditingController();
  File? _selectedimage;
  void _saveplace() {
    final entertilte = _titlecontroler.text;

    if (entertilte.isEmpty || _selectedimage == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(entertilte, _selectedimage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titlecontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new place'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'title'),
              controller: _titlecontroler,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              width: 16,
              height: 16,
            ),
            Imageinput(
              onpickedimage: (image) {
                _selectedimage = image;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            const LocationInput(),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _saveplace,
              icon: const Icon(Icons.add),
              label: const Text('add places'),
            )
          ],
        ),
      ),
    );
  }
}
