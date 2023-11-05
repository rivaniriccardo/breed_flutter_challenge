import 'package:breed_flutter_challenge/feature/breed_images/bloc/breed_images_bloc.dart';
import 'package:breed_flutter_challenge/feature/breed_images/repo/breed_images_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockBreedImagesRepo extends Mock implements BreedImagesRepo {}

void main() {
  late MockBreedImagesRepo repo;

  setUp(() {
    repo = MockBreedImagesRepo();
  });

  blocTest<BreedImagesBloc, BreedImagesState>(
    'emits [] when nothing is added',
    build: () => BreedImagesBloc(breedImagesRepo: repo),
    expect: () => [],
  );

  blocTest<BreedImagesBloc, BreedImagesState>(
    'emits [BreedImageState.loaded] when fetch is added',
    setUp: () {
      when(() => repo.getBreedImages('breed')).thenAnswer(
        (_) => Future.value([]),
      );
    },
    build: () => BreedImagesBloc(breedImagesRepo: repo),
    act: (bloc) => bloc.add(const BreedImagesEvent.fetch('breed')),
    expect: () => [
      const BreedImagesState.loading(),
      const BreedImagesState.loaded(imgs: []),
    ],
  );

  blocTest<BreedImagesBloc, BreedImagesState>(
    'emits [BreedImageState.loaded] when fetch is added and got images',
    setUp: () {
      when(() => repo.getBreedImages('breed')).thenAnswer(
        (_) => Future.value(
          [
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
          ],
        ),
      );
    },
    build: () => BreedImagesBloc(breedImagesRepo: repo),
    act: (bloc) => bloc.add(const BreedImagesEvent.fetch('breed')),
    expect: () => [
      const BreedImagesState.loading(),
      const BreedImagesState.loaded(
        imgs: [
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
        ],
      ),
    ],
  );

  blocTest<BreedImagesBloc, BreedImagesState>(
    'emits [BreedImageState.error] when fetch is added and got error',
    setUp: () {
      when(() => repo.getBreedImages('breed')).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => BreedImagesBloc(breedImagesRepo: repo),
    act: (bloc) => bloc.add(const BreedImagesEvent.fetch('breed')),
    expect: () => [
      const BreedImagesState.loading(),
      const BreedImagesState.error(),
    ],
  );
}
