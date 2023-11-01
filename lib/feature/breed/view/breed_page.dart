import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breed/bloc/breed_bloc.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
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
            breed,
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
                images: state.imgs,
                subBreeds: breed.subBreeds,
              ),
              error: (state) => BreedError(
                breed: breed,
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
    required this.subBreeds,
    required this.images,
    super.key,
  });

  final List<String> subBreeds;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    // Ritorna una card dove viene mostrato il numero di sottorazze
    // e un pulsante per navigare lla pagina con l'elenco delle sottorazze
    // Poi subito dopo l'elenco delle immagini della razza
    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text(
              'Sub-breeds: ${subBreeds.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: subBreeds.isEmpty
                ? null
                : ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/sub-breeds',
                        arguments: subBreeds,
                      );
                    },
                    child: const Text('View'),
                  ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return Card(
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            );
          },
        ),
      ],
    );

    // return GridView.builder(
    //   itemCount: images.length,
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //   ),
    //   itemBuilder: (context, index) {
    //     return Card(
    //       child: Image.network(
    //         images[index],
    //         fit: BoxFit.cover,
    //       ),
    //     );
    //   },
    // );
    // return ListView.builder(
    //   itemCount: subBreeds.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //       child: ListTile(
    //         title: Text(
    //           'Sub-breed name: ${subBreeds[index]}',
    //           style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

class BreedError extends StatelessWidget {
  const BreedError({
    required this.breed,
    Key? key,
  }) : super(key: key);

  final Breed breed;

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
                    BreedEvent.fetch(breed),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
