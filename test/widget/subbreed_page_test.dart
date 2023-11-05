import 'package:bloc_test/bloc_test.dart';
import 'package:breed_flutter_challenge/feature/subbreed/bloc/subbreed_bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreed/view/subbreed_page.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'widget_builder.dart';

class MockSubBreedBloc extends MockBloc<SubBreedEvent, SubBreedState>
    implements SubBreedBloc {}

class MockSubBreedEvent extends Fake implements SubBreedEvent {}

class MockSubBreedState extends Fake implements SubBreedState {}

Future<void> main() async {
  group('Sub breed page', () {
    late SubBreedBloc bloc;

    setUpAll(() {
      registerFallbackValue(MockSubBreedEvent());
      registerFallbackValue(MockSubBreedState());
      bloc = MockSubBreedBloc();
      GetIt.I.registerSingleton<SubBreedBloc>(bloc);
    });

    testGoldens('Sub breed page without errors', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const SubBreedState.loaded(
              imageUrl:
                  'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
            ),
          ],
        ),
        initialState: const SubBreedState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const SubBreedPage(
            breedName: 'African',
            subBreed: Breed(
              name: 'German',
              subBreeds: [],
            ),
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'sub_breed_page');
      });
    });

    testGoldens('Sub breed page with error', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const SubBreedState.error(),
          ],
        ),
        initialState: const SubBreedState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const SubBreedPage(
            breedName: 'African',
            subBreed: Breed(
              name: 'German',
              subBreeds: [],
            ),
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'sub_breed_page_error');
      });
    });
  });
}
