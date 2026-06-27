import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favorite_place/models/place.dart';
import 'dart:io';

class PlacesNotifier extends Notifier<List<Place>> {
  @override
  List<Place> build() {
    return [];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);

    // Direct state mutation using the spread operator
    state = [...state, newPlace];
  }

  // Delete Item Function
  void deletePlace(String id) {
    // Filter the list and assign it directly to state
    state = state.where((place) => place.id != id).toList();
  }
}

final placesProvider = NotifierProvider<PlacesNotifier, List<Place>>(() {
  return PlacesNotifier();
});
