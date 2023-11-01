import 'package:freezed_annotation/freezed_annotation.dart';

part 'breeds.freezed.dart';
part 'breeds.g.dart';

/*
SAMPLE:
{
    "message": {
        "affenpinscher": [],
        "australian": [
            "shepherd"
        ],
        "bulldog": [
            "boston",
            "english",
            "french"
        ]
    },
    "status": "success"
}
*/

@freezed
class Breeds with _$Breeds {
  const factory Breeds({
    required Map<String, List<String>> message,
    required String status,
  }) = _Breeds;

  factory Breeds.fromJson(Map<String, dynamic> json) => _$BreedsFromJson(json);
}
