import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breed/bloc/breed_bloc.dart';
import 'package:breed_flutter_challenge/feature/breed_images/view/breed_images_page.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/feature/subbreeds/view/subbreeds_page.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedPage extends StatelessWidget {
  const BreedPage({required this.breed, super.key});

  final Breed breed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BreedBloc>()
        ..add(
          BreedEvent.fetch(
            breed.name,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Breed: ${breed.name}'),
        ),
        body: BlocBuilder<BreedBloc, BreedState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => BreedDetail(
                imageUrl: state.imageUrl,
                breedName: breed.name,
              ),
              error: (state) => BreedError(
                breedName: breed.name,
              ),
            );
          },
        ),
      ),
    );
  }
}

class BreedDetail extends StatelessWidget {
  const BreedDetail({
    required this.imageUrl,
    required this.breedName,
    super.key,
  });

  final String imageUrl;
  final String breedName;

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
                  onPressed: () {
                    context.read<BreedBloc>().add(
                          BreedEvent.reFetch(breedName),
                        );
                  },
                  child: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Card(
          child: ListTile(
            title: Text(
              'Gallery of $breedName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BreedImagesPage(breedName: breedName),
                ),
              ),
              child: const Text('View'),
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text(
              'Sub-breeds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubBreedsPage(breedName: breedName),
                ),
              ),
              child: const Text('View'),
            ),
          ),
        ),
      ],
    );
  }
}

class BreedError extends StatelessWidget {
  const BreedError({
    required this.breedName,
    Key? key,
  }) : super(key: key);

  final String breedName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Error fetching breed',
          ),
          ElevatedButton(
            onPressed: () {
              context.read<BreedBloc>().add(
                    BreedEvent.fetch(breedName),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
