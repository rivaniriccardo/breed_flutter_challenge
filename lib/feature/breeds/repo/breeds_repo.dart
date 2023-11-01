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

    final decodedBreeds = Breeds.fromJson(
      jsonDecode(
        response.body,
      ),
    );

    final breeds = List<Breed>.from(
      decodedBreeds.message.entries.map(
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
}
