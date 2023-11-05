import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:breed_flutter_challenge/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('random image', () {
    testWidgets(
        'tap on the first breed, verify the navigation to the breed page',
        (tester) async {
      app.main();

      await tester.pumpAndSettle();

      await tester.tap(find.text('View').first);

      await tester.pumpAndSettle();

      expect(find.textContaining('Breed:'), findsOneWidget);
    });
  });
}
