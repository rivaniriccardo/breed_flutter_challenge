import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breed/bloc/breed_bloc.dart';
import 'package:breed_flutter_challenge/feature/breed_images/view/breed_images_page.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/feature/common/breed_random_image.dart';
import 'package:breed_flutter_challenge/feature/common/card_list_item.dart';
import 'package:breed_flutter_challenge/feature/common/fetch_error.dart';
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
              error: (state) => FetchError(
                message: 'Error fetching breed',
                onRetry: () => context.read<BreedBloc>().add(
                      BreedEvent.fetch(
                        breed.name,
                      ),
                    ),
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
        Expanded(
          child: BreedRandomImage(
            imageUrl: imageUrl,
            onPressed: () => context.read<BreedBloc>().add(
                  BreedEvent.reFetch(breedName),
                ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CardListItem(
          title: 'Gallery of $breedName',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreedImagesPage(breedName: breedName),
            ),
          ),
        ),
        CardListItem(
          title: 'Sub breeds',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubBreedsPage(breedName: breedName),
            ),
          ),
        ),
      ],
    );
  }
}
