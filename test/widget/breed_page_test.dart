import 'package:bloc_test/bloc_test.dart';
import 'package:breed_flutter_challenge/feature/breed/bloc/breed_bloc.dart';
import 'package:breed_flutter_challenge/feature/breed/view/breed_page.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'widget_builder.dart';

class MockBreedBloc extends MockBloc<BreedEvent, BreedState>
    implements BreedBloc {}

class MockBreedEvent extends Fake implements BreedEvent {}

class MockBreedState extends Fake implements BreedState {}

Future<void> main() async {
  group('Breeds page', () {
    late BreedBloc breedBloc;

    setUpAll(() {
      registerFallbackValue(MockBreedEvent());
      registerFallbackValue(MockBreedState());
      breedBloc = MockBreedBloc();
      GetIt.I.registerSingleton<BreedBloc>(breedBloc);
    });

    testGoldens('Breed page without errors', (tester) async {
      whenListen(
        breedBloc,
        Stream.fromIterable(
          [
            const BreedState.loaded(
              imageUrl:
                  'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
            ),
          ],
        ),
        initialState: const BreedState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const BreedPage(
            breed: Breed(
              name: 'African',
              subBreeds: [],
            ),
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'breed_page');
      });
    });

    testGoldens('Breed page with error', (tester) async {
      whenListen(
        breedBloc,
        Stream.fromIterable(
          [
            const BreedState.error(),
          ],
        ),
        initialState: const BreedState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const BreedPage(
            breed: Breed(
              name: 'African',
              subBreeds: [],
            ),
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'breed_page_error');
      });
    });
  });
}
