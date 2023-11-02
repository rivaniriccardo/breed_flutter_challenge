import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/feature/common/card_list_item.dart';
import 'package:breed_flutter_challenge/feature/common/fetch_error.dart';
import 'package:breed_flutter_challenge/feature/subbreed/view/subbreed_page.dart';
import 'package:breed_flutter_challenge/feature/subbreeds/bloc/subbreeds_bloc.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubBreedsPage extends StatelessWidget {
  const SubBreedsPage({required this.breedName, super.key});

  final String breedName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SubBreedsBloc>()..add(SubBreedsEvent.fetch(breedName)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sub Breeds'),
        ),
        body: BlocBuilder<SubBreedsBloc, SubBreedsState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => SubBreedsList(
                subBreeds: state.breeds,
                breedName: breedName,
              ),
              error: (state) => FetchError(
                message: 'Error fetching sub breeds',
                onRetry: () => context.read<SubBreedsBloc>().add(
                      SubBreedsEvent.fetch(breedName),
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubBreedsList extends StatelessWidget {
  const SubBreedsList({
    required this.subBreeds,
    required this.breedName,
    super.key,
  });

  final List<Breed> subBreeds;
  final String breedName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SubBreedsListWidget(
            subBreeds: subBreeds,
            breedName: breedName,
          ),
        ),
      ],
    );
  }
}

class SubBreedsListWidget extends StatelessWidget {
  const SubBreedsListWidget({
    required this.breedName,
    required this.subBreeds,
    super.key,
  });

  final String breedName;
  final List<Breed> subBreeds;

  @override
  Widget build(BuildContext context) {
    return subBreeds.isEmpty
        ? const Center(
            child: Text("No sub breeds found",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )))
        : ListView.builder(
            itemCount: subBreeds.length,
            itemBuilder: (context, index) {
              return CardListItem(
                title: subBreeds[index].name,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubBreedPage(
                      subBreed: subBreeds[index],
                      breedName: breedName,
                    ),
                  ),
                ),
              );
            },
          );
  }
}
