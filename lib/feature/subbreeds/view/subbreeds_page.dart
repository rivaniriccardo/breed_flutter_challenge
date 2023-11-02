import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
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
          title: const Text('Sub-Breeds'),
        ),
        body: BlocBuilder<SubBreedsBloc, SubBreedsState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => SubBreedsList(
                breeds: state.breeds,
              ),
              error: (state) => BreedsError(breedName: breedName),
            );
          },
        ),
      ),
    );
  }
}

class SubBreedsList extends StatelessWidget {
  const SubBreedsList({
    required this.breeds,
    super.key,
  });

  final List<Breed> breeds;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SubBreedsListWidget(
            breeds: breeds,
          ),
        ),
      ],
    );
  }
}

class SubBreedsListWidget extends StatelessWidget {
  const SubBreedsListWidget({
    required this.breeds,
    super.key,
  });

  final List<Breed> breeds;

  @override
  Widget build(BuildContext context) {
    return breeds.isEmpty
        ? const Center(
            child: Text("No sub-breeds found",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )))
        : ListView.builder(
            itemCount: breeds.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(breeds[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  // onTap: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SubBreedPage(breed: breeds[index]),
                  //   ),
                  // ),
                ),
              );
            },
          );
  }
}

class BreedsError extends StatelessWidget {
  const BreedsError({
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
            'Error fetching sub-breeds',
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SubBreedsBloc>().add(
                    SubBreedsEvent.fetch(breedName),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
