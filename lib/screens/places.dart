import 'package:favorite_place/screens/new_place.dart';
import 'package:favorite_place/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:favorite_place/models/place.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});
  @override
  State<PlacesScreen> createState() {
    return _PlacesScreenState();
  }
}

class _PlacesScreenState extends State<PlacesScreen> {
  final List<Place> _registeredPlaces = [
    Place('Osaka'),
  ];

  void addPlace(Place place) {
    setState(() {
      _registeredPlaces.add(place);
    });
  }

  void deletePlace(Place place) {
    var expenseIndex = _registeredPlaces.indexOf(place);
    setState(() {
      _registeredPlaces.remove(place);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text('${place.title} deleted.'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _openPlaceOverlay() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewPlace(addPlace),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No places found. Start adding some!'),
    );

    if (_registeredPlaces.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _registeredPlaces.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (_) {
            deletePlace(_registeredPlaces[index]);
          },
          key: ValueKey(_registeredPlaces[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: EdgeInsets.symmetric(),
          ),
          child: PlaceItem(_registeredPlaces[index]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: _openPlaceOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
