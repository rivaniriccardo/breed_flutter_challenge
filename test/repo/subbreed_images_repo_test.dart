import 'dart:convert';

import 'package:breed_flutter_challenge/feature/subbreed_images/repo/subbreed_images_repo.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockRestClient extends Mock implements RestClient {}

void main() {
  late RestClient restClient;
  late SubBreedImagesRepo repo;
  group('Breeds repo', () {
    setUpAll(() {
      restClient = MockRestClient();
      repo = SubBreedImagesRepo(
        restClient: restClient,
      );
    });
    test('returns a list of sub breed images', () async {
      final mockResponse = {
        "message": [
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg",
          "https://images.dog.ceo/breeds/hound-afghan/n02088094_10822.jpg",
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

      final imgs = await repo.getSubBreedImages('breed', 'subBreed');

      expect(imgs.length, 4);
      expect(
        imgs[0],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg',
      );
      expect(
        imgs[1],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_10263.jpg',
      );
      expect(
        imgs[2],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_10715.jpg',
      );
      expect(
        imgs[3],
        'https://images.dog.ceo/breeds/hound-afghan/n02088094_10822.jpg',
      );
    });
  });
}
