import 'package:breed_flutter_challenge/feature/breed/bloc/breed_bloc.dart';
import 'package:breed_flutter_challenge/feature/breed/repo/breed_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockBreedRepo extends Mock implements BreedRepo {}

void main() {
  late MockBreedRepo repo;

  setUp(() {
    repo = MockBreedRepo();
  });

  blocTest<BreedBloc, BreedState>(
    'emits [] when nothing is added',
    build: () => BreedBloc(breedRepo: repo),
    expect: () => [],
  );

  blocTest<BreedBloc, BreedState>(
    'emits [BreedImageState.loaded] when fetch is added',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed')).thenAnswer(
        (_) => Future.value(
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
        ),
      );
    },
    build: () => BreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const BreedEvent.fetch('breed')),
    expect: () => [
      const BreedState.loading(),
      const BreedState.loaded(
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      ),
    ],
  );

  blocTest<BreedBloc, BreedState>(
    'emits [BreedImageState.error] when fetch is added and got error',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed')).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => BreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const BreedEvent.fetch('breed')),
    expect: () => [
      const BreedState.loading(),
      const BreedState.error(),
    ],
  );

  blocTest<BreedBloc, BreedState>(
    'emits [BreedImageState.loaded] when reFetch is added',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed')).thenAnswer(
        (_) => Future.value(
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
        ),
      );
    },
    build: () => BreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const BreedEvent.reFetch('breed')),
    seed: () => const BreedState.loaded(
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1002.jpg'),
    expect: () => [
      const BreedState.loaded(
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      ),
    ],
  );

  blocTest<BreedBloc, BreedState>(
    'emits [BreedImageState.error] when reFetch is added and got error',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed')).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => BreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const BreedEvent.reFetch('breed')),
    seed: () => const BreedState.loaded(
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1002.jpg'),
    expect: () => [
      const BreedState.error(),
    ],
  );
}
