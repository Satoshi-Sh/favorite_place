import 'package:flutter/material.dart';
import 'package:favorite_place/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final titleController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void showInvalidInput() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure to enter a valid title.'),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void submitPlaceData() {
    if (titleController.text.trim().isEmpty) {
      showInvalidInput();
      return;
    }
    ref.read(placesProvider.notifier).addPlace(titleController.text.trim());
    Navigator.pop(context); // Closes this screen and goes back to the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          // Made padding symmetric (16 on both left and right sides)
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLength: 50,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitPlaceData,
                child: const Text('Save Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
