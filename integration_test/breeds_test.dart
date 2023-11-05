import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:breed_flutter_challenge/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('random image', () {
    testWidgets('tap on the refresh button, verify new image', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      expect(find.text('Random image'), findsOneWidget);

      final randomImage = find.byKey(const Key('random_image'));
      expect(randomImage, findsOneWidget);

      final imageUrl = tester.widget<Image>(randomImage).image as NetworkImage;

      final fab = find.byIcon(Icons.refresh);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      final newImageUrl =
          tester.widget<Image>(randomImage).image as NetworkImage;

      expect(imageUrl.url, isNot(newImageUrl.url));
    });
  });
}
