import 'dart:convert';

import 'package:breed_flutter_challenge/feature/subbreeds/repo/subbreeds_repo.dart';
import 'package:breed_flutter_challenge/model/model.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockRestClient extends Mock implements RestClient {}

void main() {
  late RestClient restClient;
  late SubBreedsRepo repo;
  group('Breeds repo', () {
    setUpAll(() {
      restClient = MockRestClient();
      repo = SubBreedsRepo(
        restClient: restClient,
      );
    });
  });
  test('returns a list of sub breeds', () async {
    final mockResponse = {
      "message": [
        "afghan",
        "basset",
        "blood",
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

    final breeds = await repo.getSubBreeds('test');

    expect(breeds.length, 3);
    expect(breeds[0], const Breed(name: 'afghan', subBreeds: []));
    expect(breeds[1], const Breed(name: 'basset', subBreeds: []));
    expect(breeds[2], const Breed(name: 'blood', subBreeds: []));
  });
}
