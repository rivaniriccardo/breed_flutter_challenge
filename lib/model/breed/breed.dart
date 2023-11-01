import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed.freezed.dart';
part 'breed.g.dart';

/*
SAMPLE:
"australian": [
            "shepherd"
        ]
*/

@freezed
class Breed with _$Breed {
  const factory Breed({
    required String breed,
    required List<String> subBreeds,
  }) = _Breed;

  factory Breed.fromJson(Map<String, dynamic> json) => _$BreedFromJson(json);
}
