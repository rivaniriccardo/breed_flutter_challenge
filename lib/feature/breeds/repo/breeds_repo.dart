import 'dart:convert';

import 'package:breed_flutter_challenge/model/breeds/breeds.dart';
import 'package:breed_flutter_challenge/utils/utils.dart';
import 'package:injectable/injectable.dart';

@injectable
class BreedsRepo {
  BreedsRepo({
    required this.restClient,
  });

  final RestClient restClient;

  Future<Breeds> getBreeds() async {
    final response = await restClient.get(
      api: '/list/all',
      endpoint: 'https://dog.ceo/api/breeds',
    );
    final breeds = Breeds.fromJson(
      jsonDecode(
        response.body,
      ),
    );

    return breeds;
  }
}
