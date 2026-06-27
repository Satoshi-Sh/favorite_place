import 'package:flutter/material.dart';
// Make sure to adjust this import path to match your model's location
import 'package:favorite_place/models/place.dart';

class PlaceDetail extends StatelessWidget {
  // Pass the data object directly through the constructor
  final Place place;

  const PlaceDetail({
    super.key,
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Displays the selected place's title in the top bar
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}
