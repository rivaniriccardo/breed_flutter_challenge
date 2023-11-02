import 'package:flutter/material.dart';

class BreedRandomImage extends StatelessWidget {
  const BreedRandomImage({
    required this.breedName,
    required this.imageUrl,
    required this.onPressed,
    super.key,
  });

  final String breedName;
  final String imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Random image of $breedName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ),
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.network(
                        imageUrl,
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: () => onPressed(),
                  child: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
