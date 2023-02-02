import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../widgets/image_input.dart';
import '../providers/places.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = 'add_New_Place';
  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  void _selectedImage(File? image) {

    _pickedImage = image;
  }
  void selectedLocation(double lat, double lng){
    _pickedLocation=PlaceLocation(latitude: lat, longitude: lng);
  }
  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedLocation==null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Adding New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Column(
            children: [
              TextField(

                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              ImageInput(_selectedImage),
              const SizedBox(height: 10,),
              LocationInput(selectedLocation),

            ],
          )),
          ElevatedButton.icon(
            onPressed: _savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          ),
        ],
      ),
    );
  }
}
