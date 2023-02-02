import 'package:flutter/material.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).getData(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                builder: (ctx, place, ch) => place.items.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                                'No places added so far. Let\'s do it together'),
                            TextButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(AddPlaceScreen.routeName),
                              icon: const Icon(Icons.add),
                              label: const Text('Add Places now'),
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: place.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(place.items[i].image),
                          ),
                          title: Text(
                            place.items[i].title,
                          ),
                          subtitle: Text(place.items[i].location!.address!),
                          onTap: () {
                            Navigator.of(context).pushNamed(PlaceDetailScreen.routeName, arguments: place.items[i].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
