import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breed_images/bloc/breed_images_bloc.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedImagesPage extends StatelessWidget {
  const BreedImagesPage({required this.breedName, super.key});

  final String breedName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BreedImagesBloc>()
        ..add(
          BreedImagesEvent.fetch(
            breedName,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Breed: $breedName'),
        ),
        body: BlocBuilder<BreedImagesBloc, BreedImagesState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => BreedGallery(
                images: state.imgs,
              ),
              error: (state) => BreedError(
                breedName: breedName,
              ),
            );
          },
        ),
      ),
    );
  }
}

class BreedGallery extends StatelessWidget {
  const BreedGallery({
    required this.images,
    super.key,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
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
            'Error fetching images',
          ),
          ElevatedButton(
            onPressed: () {
              context.read<BreedImagesBloc>().add(
                    BreedImagesEvent.fetch(breedName),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
