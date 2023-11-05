import 'package:bloc_test/bloc_test.dart';
import 'package:breed_flutter_challenge/feature/subbreeds/bloc/subbreeds_bloc.dart';
import 'package:breed_flutter_challenge/feature/subbreeds/view/subbreeds_page.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import 'widget_builder.dart';

class MockSubBreedsBloc extends MockBloc<SubBreedsEvent, SubBreedsState>
    implements SubBreedsBloc {}

class MockSubBreedsEvent extends Fake implements SubBreedsEvent {}

class MockSubBreedsState extends Fake implements SubBreedsState {}

Future<void> main() async {
  group('Sub breeds page', () {
    late SubBreedsBloc bloc;

    setUpAll(() {
      registerFallbackValue(MockSubBreedsEvent());
      registerFallbackValue(MockSubBreedsState());
      bloc = MockSubBreedsBloc();
      GetIt.I.registerSingleton<SubBreedsBloc>(bloc);
    });

    testGoldens('Sub breeds page without errors', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const SubBreedsState.loaded(
              breeds: [
                Breed(
                  name: 'German',
                  subBreeds: [],
                ),
                Breed(
                  name: 'Shepherd',
                  subBreeds: [],
                ),
              ],
            ),
          ],
        ),
        initialState: const SubBreedsState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const SubBreedsPage(
            breedName: 'African',
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'sub_breeds_page');
      });
    });

    testGoldens('Sub breed images page with error', (tester) async {
      whenListen(
        bloc,
        Stream.fromIterable(
          [
            const SubBreedsState.error(),
          ],
        ),
        initialState: const SubBreedsState.loading(),
      );

      await mockNetworkImages(() async {
        final builder = getDefaultBuilder(
          const SubBreedsPage(
            breedName: 'African',
          ),
        );

        await tester.pumpDeviceBuilder(builder);
        await screenMatchesGolden(tester, 'sub_breeds_page_error');
      });
    });
  });
}
