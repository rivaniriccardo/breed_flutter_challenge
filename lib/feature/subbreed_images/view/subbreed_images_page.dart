import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/feature/subbreed_images/bloc/subbreed_images_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubBreedImagesPage extends StatelessWidget {
  const SubBreedImagesPage({
    required this.breedName,
    required this.subBreedName,
    super.key,
  });

  final String breedName;
  final String subBreedName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubBreedImagesBloc>()
        ..add(
          SubBreedImagesEvent.fetch(
            breedName,
            subBreedName,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sub-breed: $breedName/$subBreedName'),
        ),
        body: BlocBuilder<SubBreedImagesBloc, SubBreedImagesState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => BreedGallery(
                images: state.imgs,
              ),
              error: (state) => BreedError(
                breedName: breedName,
                subBreedName: subBreedName,
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
    required this.subBreedName,
    Key? key,
  }) : super(key: key);

  final String breedName;
  final String subBreedName;

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
              context.read<SubBreedImagesBloc>().add(
                    SubBreedImagesEvent.fetch(
                      breedName,
                      subBreedName,
                    ),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
