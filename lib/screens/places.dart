import 'package:favorite_place/screens/new_place.dart';
import 'package:favorite_place/screens/place_detail.dart';
import 'package:favorite_place/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:favorite_place/models/place.dart';
import 'package:favorite_place/providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget mainContent = Center(
      child: Text('No places found. Start adding some!'),
    );

    final List<Place> registeredPlaces = ref.watch(placesProvider);

    void openPlaceOverlay() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => NewPlace(),
        ),
      );
    }

    if (registeredPlaces.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: registeredPlaces.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (_) {
            ref
                .read(placesProvider.notifier)
                .deletePlace(registeredPlaces[index].id);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(
                content: Text('${registeredPlaces[index].title} deleted.'),
                duration: const Duration(seconds: 3),
              ),
            );
          },
          key: ValueKey(registeredPlaces[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error,
            margin: EdgeInsets.symmetric(),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetail(place: registeredPlaces[index]),
                ),
              );
            },
            child: PlaceItem(registeredPlaces[index]),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: openPlaceOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: mainContent,
    );
  }
}
