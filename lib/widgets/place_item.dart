import 'package:flutter/material.dart';
import '../models/place.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem(this.place, {super.key});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(place.image),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                place.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
