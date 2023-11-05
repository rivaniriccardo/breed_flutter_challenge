import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('Rest Client', () {
    setUpAll(() {
      registerFallbackValue(Uri());
    });

    test('GET', () async {
      final restClient = _getRestClient(MockHttpClient());
      when(() => restClient.httpClient.get(
            captureAny(),
            headers: captureAny(named: 'headers'),
          )).thenAnswer(
        (_) => Future.value(http.Response('', 200)),
      );
      final r = await restClient.get(
        api: 'api',
      );
      expect(r.statusCode, 200);
    });
  });
}

RestClient _getRestClient(MockHttpClient httpClient) =>
    RestClient(httpClient: httpClient);
