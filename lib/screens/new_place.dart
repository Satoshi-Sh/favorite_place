import 'package:flutter/material.dart';
import 'package:favorite_place/models/place.dart';

class NewPlace extends StatefulWidget {
  const NewPlace(this.addPlace, {super.key});

  final Function(Place) addPlace;

  @override
  State<NewPlace> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends State<NewPlace> {
  final _titleController = TextEditingController();

  void _showDialog() {
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

  void _submitPlaceData() {
    if (_titleController.text.trim().isEmpty) {
      _showDialog();
      return;
    }
    widget.addPlace(
      Place(_titleController.text.trim()),
    );
    Navigator.pop(context); // Closes this screen and goes back to the list
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
                controller: _titleController,
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
                onPressed: _submitPlaceData,
                child: const Text('Save Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
