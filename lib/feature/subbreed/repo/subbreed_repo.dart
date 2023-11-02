import 'dart:convert';

import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubBreedRepo {
  SubBreedRepo({
    required this.restClient,
  });

  final RestClient restClient;

  Future<String> getBreedRandomImage(
      String breedName, String subBreedName) async {
    final response = await restClient.get(
      api: '/$breedName/$subBreedName/images/random',
      endpoint: 'https://dog.ceo/api/breed',
    );

    final decoded = jsonDecode(
      response.body,
    );

    final imageUrl = decoded['message'];

    return imageUrl;
  }
}
