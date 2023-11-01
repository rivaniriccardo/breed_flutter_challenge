import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breeds/bloc/breeds_bloc.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedsPage extends StatelessWidget {
  const BreedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BreedsBloc>()..add(const BreedsEvent.fetch()),
      child: Scaffold(
        body: BlocBuilder<BreedsBloc, BreedsState>(
          builder: (context, state) {
            return state.map(
              loading: (state) => const AppLoading(),
              loaded: (state) => BreedsList(
                breeds: state.breeds,
              ),
              error: (state) => const BreedsError(),
            );
          },
        ),
      ),
    );
  }
}

class BreedsList extends StatelessWidget {
  const BreedsList({
    required this.breeds,
    super.key,
  });

  final Breeds breeds;

  @override
  Widget build(BuildContext context) {
    // Our model, breeds.message is a Map<String, List<String>>
    // We need to convert it to a List<String> to use it in a ListView
    // Ordina le stringhe in ordine alfabetico
    final breedsList = breeds.message.keys.toList()
      ..sort(
        (a, b) => a.compareTo(b),
      );

    return ListView.builder(
      itemCount: breedsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(breedsList[index]),
        );
      },
    );
  }
}

class BreedsError extends StatelessWidget {
  const BreedsError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Error fetching breeds',
          ),
          ElevatedButton(
            onPressed: () {
              context.read<BreedsBloc>().add(
                    const BreedsEvent.fetch(),
                  );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
