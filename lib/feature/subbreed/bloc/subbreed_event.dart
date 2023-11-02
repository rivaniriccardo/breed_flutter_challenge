part of 'subbreed_bloc.dart';

@freezed
class SubBreedEvent with _$SubBreedEvent {
  const factory SubBreedEvent.fetch(String breedName, String subBreedName) =
      _Fetch;
  const factory SubBreedEvent.reFetch(String breedName, String subBreedname) =
      _ReFetch;
}
