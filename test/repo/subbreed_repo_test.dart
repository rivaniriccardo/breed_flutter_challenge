import 'dart:convert';

import 'package:breed_flutter_challenge/feature/subbreed/repo/subbreed_repo.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockRestClient extends Mock implements RestClient {}

void main() {
  late RestClient restClient;
  late SubBreedRepo repo;
  group('Breeds repo', () {
    setUpAll(() {
      restClient = MockRestClient();
      repo = SubBreedRepo(
        restClient: restClient,
      );
    });
  });

  test('returns a sub breed random image', () async {
    final mockResponse = {
      "message":
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_3593.jpg",
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

    final imageUrl = await repo.getBreedRandomImage('breed', 'subBreed');

    expect(
      imageUrl,
      'https://images.dog.ceo/breeds/hound-afghan/n02088094_3593.jpg',
    );
  });
}
