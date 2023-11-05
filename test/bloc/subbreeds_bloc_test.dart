import 'package:breed_flutter_challenge/feature/subbreeds/bloc/subbreeds_bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreeds/repo/subbreeds_repo.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockSubBreedsRepo extends Mock implements SubBreedsRepo {}

void main() {
  late MockSubBreedsRepo repo;

  setUp(() {
    repo = MockSubBreedsRepo();
  });

  blocTest<SubBreedsBloc, SubBreedsState>(
    'emits [] when nothing is added',
    build: () => SubBreedsBloc(breedsRepo: repo),
    expect: () => [],
  );

  blocTest<SubBreedsBloc, SubBreedsState>(
    'emits [SubBreedsState.loaded] when fetch is added and got data',
    setUp: () {
      when(
        () => repo.getSubBreeds('breed'),
      ).thenAnswer(
        (_) => Future.value(
          [
            const Breed(
              name: 'breed',
              subBreeds: [],
            ),
          ],
        ),
      );
    },
    build: () => SubBreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(
      const SubBreedsEvent.fetch('breed'),
    ),
    expect: () => [
      const SubBreedsState.loading(),
      const SubBreedsState.loaded(
        breeds: [
          Breed(
            name: 'breed',
            subBreeds: [],
          ),
        ],
      ),
    ],
  );

  blocTest<SubBreedsBloc, SubBreedsState>(
    'emits [SubBreedsState.error] when fetch is added and got error',
    setUp: () {
      when(
        () => repo.getSubBreeds('breed'),
      ).thenAnswer(
        (_) => Future.value(throw Exception()),
      );
    },
    build: () => SubBreedsBloc(breedsRepo: repo),
    act: (bloc) => bloc.add(
      const SubBreedsEvent.fetch('breed'),
    ),
    expect: () => [
      const SubBreedsState.loading(),
      const SubBreedsState.error(),
    ],
  );
}
