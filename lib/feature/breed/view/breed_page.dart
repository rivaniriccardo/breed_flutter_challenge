import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter/material.dart';

class BreedPage extends StatelessWidget {
  const BreedPage({required this.breed, super.key});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breed: ${breed.breed}'),
      ),
      body: ListView.builder(
        itemCount: breed.subBreeds.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                'Sub-breed name: ${breed.subBreeds[index]}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
