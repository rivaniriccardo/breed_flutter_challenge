import 'dart:convert';

import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubBreedImagesRepo {
  SubBreedImagesRepo({
    required this.restClient,
  });

  final RestClient restClient;

  Future<List<String>> getSubBreedImages(
      String breedName, String subBreedName) async {
    final response = await restClient.get(
      api: '/$breedName/$subBreedName/images',
      endpoint: 'https://dog.ceo/api/breed',
    );

    final decoded = jsonDecode(
      response.body,
    );

    final imgs = List<String>.from(
      decoded['message'].map(
        (img) => img,
      ),
    );

    return imgs;
  }
}
