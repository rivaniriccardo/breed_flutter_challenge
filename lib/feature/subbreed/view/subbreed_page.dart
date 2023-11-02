import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/feature/common/breed_random_image.dart';
import 'package:breed_flutter_challenge/feature/common/card_list_item.dart';
import 'package:breed_flutter_challenge/feature/subbreed/bloc/subbreed_bloc.dart';

import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubBreedPage extends StatelessWidget {
  const SubBreedPage({
    required this.breedName,
    required this.subBreed,
    super.key,
  });

  final Breed subBreed;
  final String breedName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubBreedBloc>()
        ..add(
          SubBreedEvent.fetch(
            breedName,
            subBreed.name,
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sub-breed: ${subBreed.name}'),
        ),
        body: BlocBuilder<SubBreedBloc, SubBreedState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => BreedDetail(
                imageUrl: state.imageUrl,
                breedName: breedName,
                subBreedName: subBreed.name,
              ),
              error: (state) => BreedError(
                breedName: breedName,
                subBreedName: subBreed.name,
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
    required this.subBreedName,
    super.key,
  });

  final String imageUrl;
  final String breedName;
  final String subBreedName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BreedRandomImage(
            imageUrl: imageUrl,
            breedName: subBreedName,
            onPressed: () => context.read<SubBreedBloc>().add(
                  SubBreedEvent.reFetch(
                    breedName,
                    subBreedName,
                  ),
                ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CardListItem(
          title: 'Gallery of $subBreedName',
          onPressed: () => {},
          // onPressed: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SubBreedImagesPage(breedName: breedName),
          //   ),
          // ),
        ),
      ],
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
            'Error fetching breed',
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SubBreedBloc>().add(
                    SubBreedEvent.fetch(
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
