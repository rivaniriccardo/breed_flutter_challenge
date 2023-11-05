import 'dart:convert';

import 'package:breed_flutter_challenge/feature/breed_images/repo/breed_images_repo.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockRestClient extends Mock implements RestClient {}

void main() {
  late RestClient restClient;
  late BreedImagesRepo repo;
  group('Breed Images repo', () {
    setUpAll(() {
      restClient = MockRestClient();
      repo = BreedImagesRepo(
        restClient: restClient,
      );
    });
  });
  test('returns a list of breed images', () async {
    final mockResponse = {
      "message": [
        "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
        "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
        "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
      ],
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

    final imgs = await repo.getBreedImages('hound');

    expect(imgs.length, 3);
    expect(imgs[0],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg');
    expect(imgs[1],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg');
    expect(imgs[2],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg');
  });
}
