import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breed/view/breed_page.dart';
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
        appBar: AppBar(
          title: const Text('Breeds'),
        ),
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

  final List<Breed> breeds;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: breeds.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Breed name: ${breeds[index].name}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(
              'Sub-breeds: ${breeds[index].subBreeds.length}',
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BreedPage(breed: breeds[index]),
              ),
            ),
          ),
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
