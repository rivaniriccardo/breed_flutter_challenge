import 'dart:convert';

import 'package:breed_flutter_challenge/model/model.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubBreedsRepo {
  SubBreedsRepo({
    required this.restClient,
  });

  final RestClient restClient;

  Future<List<Breed>> getSubBreeds(String breedName) async {
    final response = await restClient.get(
      api: '/$breedName/list',
      endpoint: 'https://dog.ceo/api/breed',
    );

    final decoded = jsonDecode(
      response.body,
    );

    final breeds = List<Breed>.from(
      decoded['message'].map(
        (val) {
          return Breed(
            name: val,
            subBreeds: [],
          );
        },
      ),
    );

    return breeds;
  }
}
