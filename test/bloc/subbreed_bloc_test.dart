import 'package:breed_flutter_challenge/feature/subbreed/bloc/subbreed_bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreed/repo/subbreed_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSubBreedRepo extends Mock implements SubBreedRepo {}

void main() {
  late MockSubBreedRepo repo;

  setUp(() {
    repo = MockSubBreedRepo();
  });

  blocTest<SubBreedBloc, SubBreedState>(
    'emits [] when nothing is added',
    build: () => SubBreedBloc(breedRepo: repo),
    expect: () => [],
  );

  blocTest<SubBreedBloc, SubBreedState>(
    'emits [SubBreedState.loaded] when fetch is added',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed', 'subbreed')).thenAnswer(
        (_) => Future.value(
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg'),
      );
    },
    build: () => SubBreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const SubBreedEvent.fetch('breed', 'subbreed')),
    expect: () => [
      const SubBreedState.loading(),
      const SubBreedState.loaded(
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      ),
    ],
  );

  blocTest<SubBreedBloc, SubBreedState>(
    'emits [SubBreedState.error] when fetch is added and got error',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed', 'subbreed')).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => SubBreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const SubBreedEvent.fetch('breed', 'subbreed')),
    expect: () => [
      const SubBreedState.loading(),
      const SubBreedState.error(),
    ],
  );

  blocTest<SubBreedBloc, SubBreedState>(
    'emits [SubBreedState.loaded] when reFetch is added',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed', 'subbreed')).thenAnswer(
        (_) => Future.value(
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1002.jpg'),
      );
    },
    build: () => SubBreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const SubBreedEvent.reFetch('breed', 'subbreed')),
    seed: () => const SubBreedState.loaded(
      imageUrl: 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
    ),
    expect: () => [
      const SubBreedState.loaded(
        imageUrl:
            'https://images.dog.ceo/breeds/hound-afghan/n02088094_1002.jpg',
      ),
    ],
  );

  blocTest<SubBreedBloc, SubBreedState>(
    'emits [SubBreedState.error] when reFetch is added and got error',
    setUp: () {
      when(() => repo.getBreedRandomImage('breed', 'subbreed')).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => SubBreedBloc(breedRepo: repo),
    act: (bloc) => bloc.add(const SubBreedEvent.reFetch('breed', 'subbreed')),
    seed: () => const SubBreedState.loaded(
      imageUrl: 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
    ),
    expect: () => [
      const SubBreedState.error(),
    ],
  );
}
