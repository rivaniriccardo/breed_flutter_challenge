import 'package:bloc_test/bloc_test.dart';
import 'package:breed_flutter_challenge/feature/breed_images/bloc/breed_images_bloc.dart';
import 'package:breed_flutter_challenge/feature/breed_images/view/breed_images_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'widget_builder.dart';

class MockBreedImagesBloc extends MockBloc<BreedImagesEvent, BreedImagesState>
    implements BreedImagesBloc {}

class MockBreedImagesEvent extends Fake implements BreedImagesEvent {}

class MockBreedImagesState extends Fake implements BreedImagesState {}

Future<void> main() async {
  group('Breed images page', () {
    late BreedImagesBloc bloc;

    setUpAll(() {
      registerFallbackValue(MockBreedImagesEvent());
      registerFallbackValue(MockBreedImagesState());
      bloc = MockBreedImagesBloc();
      GetIt.I.registerSingleton<BreedImagesBloc>(bloc);
    });

    testGoldens('Breed images page without errors', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const BreedImagesState.loaded(
              imgs: [
                'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
                'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
                'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
                'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
                'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
                'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
              ],
            ),
          ],
        ),
        initialState: const BreedImagesState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const BreedImagesPage(
            breedName: 'African',
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'breed_images_page');
      });
    });

    testGoldens('Breed images page with error', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const BreedImagesState.error(),
          ],
        ),
        initialState: const BreedImagesState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const BreedImagesPage(
            breedName: 'African',
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'breed_images_page_error');
      });
    });
  });
}
