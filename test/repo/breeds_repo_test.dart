import 'dart:convert';

import 'package:breed_flutter_challenge/model/model.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:breed_flutter_challenge/feature/breeds/repo/breeds_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockRestClient extends Mock implements RestClient {}

void main() {
  late RestClient restClient;
  late BreedsRepo breedsRepo;
  group('Breeds repo', () {
    setUpAll(() {
      restClient = MockRestClient();
      breedsRepo = BreedsRepo(
        restClient: restClient,
      );
    });
  });
  test('returns a list of breeds', () async {
    final mockResponse = {
      "message": {
        "affenpinscher": [],
        "bakharwal": ["indian"]
      },
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

    final breeds = await breedsRepo.getBreeds();

    expect(breeds.length, 2);
    expect(breeds[0], const Breed(name: 'affenpinscher', subBreeds: []));
    expect(breeds[1], const Breed(name: 'bakharwal', subBreeds: ['indian']));
  });

  test('returns a random image of breeds', () async {
    final mockResponse = {
      "message":
          "https://images.dog.ceo/breeds/affenpinscher/n02110627_3730.jpg",
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

    final imageUrl = await breedsRepo.getBreedsRandomImage();

    expect(
      imageUrl,
      'https://images.dog.ceo/breeds/affenpinscher/n02110627_3730.jpg',
    );
  });
}
