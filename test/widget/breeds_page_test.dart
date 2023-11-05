import 'package:bloc_test/bloc_test.dart';
import 'package:breed_flutter_challenge/feature/breeds/bloc/breeds_bloc.dart';
import 'package:breed_flutter_challenge/feature/breeds/view/breeds_page.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'widget_builder.dart';

class MockBreedsBloc extends MockBloc<BreedsEvent, BreedsState>
    implements BreedsBloc {}

class MockBreedsEvent extends Fake implements BreedsEvent {}

class MockBreedsState extends Fake implements BreedsState {}

Future<void> main() async {
  group('Breeds page', () {
    late BreedsBloc breedsBloc;

    setUpAll(() {
      registerFallbackValue(MockBreedsEvent());
      registerFallbackValue(MockBreedsState());
      breedsBloc = MockBreedsBloc();
      GetIt.I.registerSingleton<BreedsBloc>(breedsBloc);
    });

    testGoldens('Breeds page without errors', (tester) async {
      whenListen(
        breedsBloc,
        Stream.fromIterable(
          [
            const BreedsState.loaded(
              breeds: [
                Breed(
                  name: 'Affenpinscher',
                  subBreeds: ['German', 'Belgian'],
                ),
                Breed(
                  name: 'African',
                  subBreeds: [],
                )
              ],
              imageUrl:
                  'https://images.dog.ceo/breeds/african/n02116738_10024.jpg',
            ),
          ],
        ),
        initialState: const BreedsState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const BreedsPage(),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'breeds_page');
      });
    });

    testGoldens('Breeds page with error', (tester) async {
      whenListen(
        breedsBloc,
        Stream.fromIterable(
          [
            const BreedsState.error(),
          ],
        ),
        initialState: const BreedsState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const BreedsPage(),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'breeds_page_error');
      });
    });
  });
}
