import 'package:breed_flutter_challenge/core/di/injections.dart';
import 'package:breed_flutter_challenge/feature/breed/view/breed_page.dart';
import 'package:breed_flutter_challenge/feature/breeds/bloc/breeds_bloc.dart';
import 'package:breed_flutter_challenge/feature/common/app_loading.dart';
import 'package:breed_flutter_challenge/feature/common/breed_random_image.dart';
import 'package:breed_flutter_challenge/feature/common/card_list_item.dart';
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
              loaded: (state) => BreedWidget(
                breeds: state.breeds,
                imageUrl: state.imageUrl,
              ),
              error: (state) => const BreedsError(),
            );
          },
        ),
      ),
    );
  }
}

class BreedWidget extends StatelessWidget {
  const BreedWidget({
    required this.breeds,
    required this.imageUrl,
    super.key,
  });

  final List<Breed> breeds;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BreedRandomImage(
            imageUrl: imageUrl,
            onPressed: () => context.read<BreedsBloc>().add(
                  const BreedsEvent.fetchRandomImage(),
                ),
          ),
        ),
        // const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: Text('Random image of all breeds',
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20,
        //       )),
        // ),
        // Expanded(
        //   child: Stack(
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 8.0,
        //         ),
        //         child: Column(
        //           children: [
        //             Expanded(
        //               child: Image.network(
        //                 imageUrl,
        //                 width: MediaQuery.of(context).size.width,
        //                 height: 300,
        //                 fit: BoxFit.cover,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 16,
        //         right: 16,
        //         child: ElevatedButton(
        //           onPressed: () {
        //             context.read<BreedsBloc>().add(
        //                   const BreedsEvent.fetchRandomImage(),
        //                 );
        //           },
        //           child: const Icon(Icons.refresh),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Breeds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ),
        Expanded(
          child: BreedsList(
            breeds: breeds,
          ),
        ),
      ],
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
        return CardListItem(
          title: 'Breed name: ${breeds[index].name}',
          subtitle: 'Sub-breeds: ${breeds[index].subBreeds.length}',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BreedPage(breed: breeds[index]),
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
