import 'package:bloc_test/bloc_test.dart';
import 'package:breed_flutter_challenge/feature/subbreed_images/bloc/subbreed_images_bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreed_images/view/subbreed_images_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'widget_builder.dart';

class MockSubBreedImagesBloc
    extends MockBloc<SubBreedImagesEvent, SubBreedImagesState>
    implements SubBreedImagesBloc {}

class MockSubBreedImagesEvent extends Fake implements SubBreedImagesEvent {}

class MockSubBreedImagesState extends Fake implements SubBreedImagesState {}

Future<void> main() async {
  group('Sub breed images page', () {
    late SubBreedImagesBloc bloc;

    setUpAll(() {
      registerFallbackValue(MockSubBreedImagesEvent());
      registerFallbackValue(MockSubBreedImagesState());
      bloc = MockSubBreedImagesBloc();
      GetIt.I.registerSingleton<SubBreedImagesBloc>(bloc);
    });

    testGoldens('Sub breed images page without errors', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const SubBreedImagesState.loaded(
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
        initialState: const SubBreedImagesState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const SubBreedImagesPage(
            breedName: 'African',
            subBreedName: 'German',
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'sub_breed_images_page');
      });
    });

    testGoldens('Sub breed images page with error', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const SubBreedImagesState.error(),
          ],
        ),
        initialState: const SubBreedImagesState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const SubBreedImagesPage(
            breedName: 'African',
            subBreedName: 'German',
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'sub_breed_images_page_error');
      });
    });
  });
}
