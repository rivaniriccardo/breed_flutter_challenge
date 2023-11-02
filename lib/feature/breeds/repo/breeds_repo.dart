import 'dart:convert';

import 'package:breed_flutter_challenge/model/model.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class BreedsRepo {
  BreedsRepo({
    required this.restClient,
  });

  final RestClient restClient;

  Future<List<Breed>> getBreeds() async {
    final response = await restClient.get(
      api: '/list/all',
      endpoint: 'https://dog.ceo/api/breeds',
    );

    final decoded = jsonDecode(
      response.body,
    );

    final breeds = List<Breed>.from(
      decoded['message'].entries.map(
        (entry) {
          return Breed(
            name: entry.key,
            subBreeds: List<String>.from(
              entry.value.map(
                (subBreed) => subBreed,
              ),
            ),
          );
        },
      ),
    );

    return breeds;
  }

  Future<String> getBreedsRandomImage() async {
    final response = await restClient.get(
      api: '/image/random',
      endpoint: 'https://dog.ceo/api/breeds',
    );

    final decoded = jsonDecode(
      response.body,
    );

    final imageUrl = decoded['message'];

    return imageUrl;
  }
}
