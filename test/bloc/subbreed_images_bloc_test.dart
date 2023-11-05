import 'package:breed_flutter_challenge/feature/subbreed_images/bloc/subbreed_images_bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreed_images/repo/subbreed_images_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSubBreedImagesRepo extends Mock implements SubBreedImagesRepo {}

void main() {
  late MockSubBreedImagesRepo repo;

  setUp(() {
    repo = MockSubBreedImagesRepo();
  });

  blocTest<SubBreedImagesBloc, SubBreedImagesState>(
    'emits [] when nothing is added',
    build: () => SubBreedImagesBloc(breedImagesRepo: repo),
    expect: () => [],
  );

  blocTest<SubBreedImagesBloc, SubBreedImagesState>(
    'emits [SubBreedImagesState.loaded] when fetch is added',
    setUp: () {
      when(
        () => repo.getSubBreedImages('breed', 'subbreed'),
      ).thenAnswer(
        (_) => Future.value([]),
      );
    },
    build: () => SubBreedImagesBloc(breedImagesRepo: repo),
    act: (bloc) => bloc.add(
      const SubBreedImagesEvent.fetch(
        'breed',
        'subbreed',
      ),
    ),
    expect: () => [
      const SubBreedImagesState.loading(),
      const SubBreedImagesState.loaded(imgs: []),
    ],
  );

  blocTest<SubBreedImagesBloc, SubBreedImagesState>(
    'emits [SubBreedImagesState.loaded] when fetch is added and got images',
    setUp: () {
      when(
        () => repo.getSubBreedImages('breed', 'subbreed'),
      ).thenAnswer(
        (_) => Future.value(
          [
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
            "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
          ],
        ),
      );
    },
    build: () => SubBreedImagesBloc(breedImagesRepo: repo),
    act: (bloc) => bloc.add(
      const SubBreedImagesEvent.fetch('breed', 'subbreed'),
    ),
    expect: () => [
      const SubBreedImagesState.loading(),
      const SubBreedImagesState.loaded(
        imgs: [
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
        ],
      ),
    ],
  );

  blocTest<SubBreedImagesBloc, SubBreedImagesState>(
    'emits [SubBreedImagesState.error] when fetch is added and got error',
    setUp: () {
      when(
        () => repo.getSubBreedImages('breed', 'subbreed'),
      ).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => SubBreedImagesBloc(breedImagesRepo: repo),
    act: (bloc) => bloc.add(
      const SubBreedImagesEvent.fetch('breed', 'subbreed'),
    ),
    expect: () => [
      const SubBreedImagesState.loading(),
      const SubBreedImagesState.error(),
    ],
  );
}
