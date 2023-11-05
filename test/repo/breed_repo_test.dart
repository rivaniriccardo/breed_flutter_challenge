import 'dart:convert';

import 'package:breed_flutter_challenge/feature/breed/repo/breed_repo.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockRestClient extends Mock implements RestClient {}

void main() {
  late RestClient restClient;
  late BreedRepo repo;
  group('Breed repo', () {
    setUpAll(() {
      restClient = MockRestClient();
      repo = BreedRepo(
        restClient: restClient,
      );
    });
  });

  test('returns a breed random image', () async {
    final mockResponse = {
      "message":
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_5413.jpg",
      "status": "success"
    };

    when(() => restClient.get(
          api: captureAny(named: 'api'),
          endpoint: captureAny(named: 'endpoint'),
        )).thenAnswer(
      (_) => Future.value(
        http.Response(
          jsonEncode(mockResponse),
          200,
        ),
      ),
    );

    final imageUrl = await repo.getBreedRandomImage('test');

    expect(
      imageUrl,
      'https://images.dog.ceo/breeds/hound-afghan/n02088094_5413.jpg',
    );
  });
}
