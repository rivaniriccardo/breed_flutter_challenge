import 'package:freezed_annotation/freezed_annotation.dart';

part 'breed.freezed.dart';

/*
SAMPLE:
"australian": [
            "shepherd"
        ]
*/

@freezed
class Breed with _$Breed {
  const factory Breed({
    required String name,
    required List<String> subBreeds,
  }) = _Breed;
}
