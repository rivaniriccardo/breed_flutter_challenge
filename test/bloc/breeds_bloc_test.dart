import 'package:breed_flutter_challenge/feature/breeds/bloc/breeds_bloc.dart';
import 'package:breed_flutter_challenge/feature/breeds/repo/breeds_repo.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockBreedsRepo extends Mock implements BreedsRepo {}

void main() {
  late MockBreedsRepo repo;

  setUp(() {
    repo = MockBreedsRepo();
  });

  blocTest<BreedsBloc, BreedsState>(
    'emits [] when nothing is added',
    build: () => BreedsBloc(breedsRepo: repo),
    expect: () => [],
  );

  blocTest<BreedsBloc, BreedsState>(
    'emits [BreedsState.loaded] when fetch is added and got data',
    setUp: () {
      when(() => repo.getBreeds()).thenAnswer(
        (_) => Future.value(
          [
            const Breed(
              name: 'breed',
              subBreeds: [],
            ),
          ],
        ),
      );
      when(() => repo.getBreedsRandomImage()).thenAnswer(
        (_) => Future.value(
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
        ),
      );
    },
    build: () => BreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(const BreedsEvent.fetch()),
    expect: () => [
      const BreedsState.loading(),
      const BreedsState.loaded(
        breeds: [
          Breed(
            name: 'breed',
            subBreeds: [],
          ),
        ],
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      ),
    ],
  );

  blocTest<BreedsBloc, BreedsState>(
    'emits [BreedsState.error] when fetch is added and got error from getBreeds',
    setUp: () {
      when(() => repo.getBreeds()).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => BreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(const BreedsEvent.fetch()),
    expect: () => [
      const BreedsState.loading(),
      const BreedsState.error(),
    ],
  );

  blocTest<BreedsBloc, BreedsState>(
    'emits [BreedsState.error] when fetch is added and got error from getBreedsRandomImage',
    setUp: () {
      when(() => repo.getBreeds()).thenAnswer(
        (_) => Future.value([]),
      );
      when(() => repo.getBreedsRandomImage()).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => BreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(const BreedsEvent.fetch()),
    expect: () => [
      const BreedsState.loading(),
      const BreedsState.error(),
    ],
  );

  blocTest<BreedsBloc, BreedsState>(
    'emits [BreedsState.loaded] when fetchRandomImage is added and got data',
    setUp: () {
      when(() => repo.getBreedsRandomImage()).thenAnswer(
        (_) => Future.value(
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
        ),
      );
    },
    build: () => BreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(const BreedsEvent.fetchRandomImage()),
    seed: () => const BreedsState.loaded(
      breeds: [
        Breed(
          name: 'breed',
          subBreeds: [],
        ),
      ],
      imageUrl: '',
    ),
    expect: () => [
      const BreedsState.loaded(
        breeds: [
          Breed(
            name: 'breed',
            subBreeds: [],
          ),
        ],
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      ),
    ],
  );

  blocTest<BreedsBloc, BreedsState>(
    'emits [BreedsState.error] when fetchRandomImage is added and got error',
    setUp: () {
      when(() => repo.getBreedsRandomImage()).thenAnswer(
        (_) => Future.value(
          throw Exception(),
        ),
      );
    },
    build: () => BreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(const BreedsEvent.fetchRandomImage()),
    seed: () => const BreedsState.loaded(
      breeds: [
        Breed(
          name: 'breed',
          subBreeds: [],
        ),
      ],
      imageUrl: '',
    ),
    expect: () => [
      const BreedsState.error(),
    ],
  );
}
